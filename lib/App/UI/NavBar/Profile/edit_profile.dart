import 'dart:io';

import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Model/Model/UserModel.dart';
import '../../../Resources/Color.dart';
import '../../../Resources/Components/CustomizedTextField.dart';
import '../../../Utils/ShowMessage/StatusBars.dart';
import '../../../Utils/ShowMessage/Ui Helper.dart';
import '../nav_screen.dart';

class EditProfile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;

  const EditProfile(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _roleController = TextEditingController();
  final _careerController = TextEditingController();

  List<String> role = ['Manager', 'Employee', 'Intern', 'Student'];
  List<String> development = [
    'Web Development',
    'Flutter Development',
    'Flutter Flow',
  ];
  File? _image;
  File? _cvFile;
  File? _experienceLetterFile;
  File? _resultCardFile;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userModel.name!;
    _surnameController.text = widget.userModel.surName!;
    _roleController.text = widget.userModel.role!;
    _careerController.text = widget.userModel.carrier!;
  }
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomizableAppBar(
        title: 'Edit Profile',
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        leadingIcon: Icon(CupertinoIcons.back),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    border: Border.all(color: Colors.grey)),
                child: GestureDetector(
                  onTap: () {
                    showPhotoOption();
                  },
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          clipBehavior: Clip.antiAlias,
                          child: Image.file(
                            _image!.absolute,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(alignment: Alignment.center,
                            children: [
                              SizedBox(height: media.height*0.01,),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Edit Image',
                                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                                  )),

                              Image(
                                image: NetworkImage(
                                  widget.userModel.profilePictureUrl!,
                                ),
                                fit: BoxFit.cover,
                              ),
                              Container(
                                decoration: BoxDecoration(color: Colors.grey.withOpacity(.4)),
                                child: Center(
                                  child: Icon(Icons.edit,color: Colors.white,),
                                ),
                              ),
                            ],
                          )),
                ),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Edit Name',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              customizedTextField(
                controller: _nameController,
                width: 360,
                hintText: 'Name',
              ),
              SizedBox(height: media.height * 0.01),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Edit Sur Name',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              customizedTextField(
                width: 360,
                controller: _surnameController,
                hintText: 'Surname',
              ),
              SizedBox(height: media.height * 0.01),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Edit Role',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              customizedTextField(
                width: 360,
                controller: _roleController,
                hintText: 'Role',
                dropDownItems: role,
              ),
              SizedBox(height: media.height * 0.01),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Edit Career',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              customizedTextField(
                width: 360,
                controller: _careerController,
                hintText: 'Career',
                dropDownItems: development,
              ),
              SizedBox(height: media.height * 0.01),
              SizedBox(
                height: media.height * 0.02,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Change CV',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              TextButton(
                  onPressed: () {
                    pickFile((file) => _cvFile = file);
                  },
                  child: Text(
                    _cvFile != null
                        ? 'CV Selected: ${_cvFile!.path.split('/').last}'
                        : 'Re-Upload CV',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        decoration: TextDecoration.underline),
                  )),
              SizedBox(
                height: media.height * 0.02,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Change Experience Letter',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              TextButton(
                  onPressed: () {
                    pickFile((file) => _experienceLetterFile = file);
                  },
                  child: Text(
                    _experienceLetterFile != null
                        ? 'Experience Letter: ${_experienceLetterFile!.path.split('/').last}'
                        : 'Re-Upload Experience Letter',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        decoration: TextDecoration.underline),
                  )),
              SizedBox(
                height: media.height * 0.02,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Change Result Card',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              TextButton(
                  onPressed: () {
                    pickFile((file) => _resultCardFile = file);
                  },
                  child: Text(
                    _resultCardFile != null
                        ? 'Result Card: ${_resultCardFile!.path.split('/').last}'
                        : 'Re-Upload Result Card',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        decoration: TextDecoration.underline),
                  )),
              ElevatedButton(
                onPressed: (){uploadDate();},
                child: Text('Save Changes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: FColor.primaryColor1,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future PickImage(ImageSource source) async {
    try {
      final pickedImage = await _picker.pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void showPhotoOption() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Upload Picture'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    PickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  title: Text('Select from gallery'),
                  leading: Icon(Icons.photo_camera_back),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    PickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  title: Text('Take a photo'),
                  leading: Icon(Icons.camera_alt_outlined),
                )
              ],
            ),
          );
        });
  }

  Future<void> pickFile(Function(File) fileSetter) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.media);
      if (result != null) {
        File file = File(result.files.single.path!);
        setState(() {
          fileSetter(file);
        });
      } else {
        showMessage.errorToastMessage('No file selected');
      }
    } catch (e) {
      print(e.toString());
      showMessage.errorToastMessage('Failed to pick file');
    }
  }

  void uploadDate() async {
    UiHelper.showLoadingAlert('User data updating...', context);
    try {
      final String uid = widget.userModel.userId.toString();


      if (_image != null) {
        await FirebaseStorage.instance
            .ref('profilePictures')
            .child(uid)
            .delete();
        final uploadImage = await FirebaseStorage.instance
            .ref('profilePictures')
            .child(uid)
            .putFile(_image!);
        TaskSnapshot imageShot = await uploadImage;
        String imageUrl = await imageShot.ref.getDownloadURL();
        widget.userModel.profilePictureUrl = imageUrl.toString();
      }
      if (_cvFile != null) {

        await FirebaseStorage.instance
            .ref('cvFiles')
            .child('$uid-cv')
            .delete();
        final uploadCv = await FirebaseStorage.instance
            .ref('cvFiles')
            .child('$uid-cv')
            .putFile(_cvFile!);
        TaskSnapshot cvSnapshot = await uploadCv;
        String cvUrl = await cvSnapshot.ref.getDownloadURL();
        widget.userModel.cvUrl = cvUrl.toString();
      }
      if (_experienceLetterFile != null) {
        await FirebaseStorage.instance
            .ref('experienceLetters')
            .child('$uid-experienceLetters.pdf')
            .delete();
        final uploadExperienceLetter = await FirebaseStorage.instance
            .ref('experienceLetters')
            .child('$uid-experienceLetters.pdf')
            .putFile(_experienceLetterFile!);
        TaskSnapshot experienceLetterSnapshot = await uploadExperienceLetter;
        String experienceLetterUrl =
        await experienceLetterSnapshot.ref.getDownloadURL();
        widget.userModel.experienceLetterUrl = experienceLetterUrl.toString();
      }if (_resultCardFile != null) {
        await FirebaseStorage.instance
            .ref('resultFiles')
            .child('$uid-resultFiles')
            .delete();
        final uploadResult = await FirebaseStorage.instance
            .ref('resultFiles')
            .child('$uid-resultFiles')
            .putFile(_resultCardFile!);
        TaskSnapshot resultSnapshot = await uploadResult;
        String resultUrl = await resultSnapshot.ref.getDownloadURL();
        widget.userModel.resultCardUrl = resultUrl.toString();
      }
      widget.userModel.role = _roleController.text.toString();
      widget.userModel.carrier = _careerController.text.toString();
   widget.userModel.name=_nameController.text.toString();
   widget.userModel.surName=_surnameController.text.toString();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userModel.userId)
          .set(widget.userModel.toMap())
          .then(
            (value) => {
          showMessage.ToastMessage('User Information Updated'),
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavigationScreen(
                  userModel: widget.userModel,
                  user: widget.firebaseUser,
                ),
              ))
        },
      );
    } catch (e) {
      print(e.toString());
      UiHelper.showErrorDialog('Exception', e.toString(), context);
    }
  }



}
