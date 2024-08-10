import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Resources/Components/DatePickerField.dart';
import 'package:fasolution/App/UI/NavBar/NavScreen.dart';
import 'package:fasolution/App/Utils/ShowMessage/StatusBars.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Model/Model/UserModel.dart';
import '../../../Resources/Color.dart';
import '../../../Resources/Components/CustomizedTextField.dart';
import '../../../Resources/Components/GradientButton.dart';

class CompleteProfile extends StatefulWidget {
  CompleteProfile(
      {super.key, required this.FirebaseUser, required this.userModel});
  final User FirebaseUser;
  final UserModel userModel;
  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  File? _image;
  File? _cvFile;
  File? _experienceLetterFile;
  File? _resultCardFile;
  final _picker = ImagePicker();
  TextEditingController roleController = TextEditingController();
  TextEditingController developmentController = TextEditingController();
  TextEditingController dateOfJoining = TextEditingController();
  List<String> role = ['Manager', 'Employee', 'Intern', 'Student'];
  List<String> development = [
    'Web Development',
    'Flutter Development',
    'Flutter Flow',
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: media.height * .06,
              ),
              Text(
                'Let\'s complete your profile',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: FColor.black,
                    fontSize: 20),
              ),
              SizedBox(
                height: media.height * .01,
              ),
              Text(
                'It will help us to know more about you!',
                style: TextStyle(
                    color: FColor.GreyBrown,
                    fontFamily: 'Poppins',
                    fontSize: 12),
              ),
              SizedBox(
                height: media.height * 0.04,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Profile Picture',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
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
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              size: 88,
                              color: Colors.black38.withOpacity(.2),
                            ),
                            SizedBox(
                              height: media.height * 0.001,
                            ),
                            Text(
                              'Pick Profile Image',
                              style: TextStyle(
                                  fontFamily: 'Sans', color: Colors.grey),
                            )
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: media.height * 0.02,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'CV',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              TextButton(
                  onPressed: () {
                    pickFile((file) => _cvFile = file);
                  },
                  child: Text(
                    _cvFile != null
                        ? 'CV Selected: ${_cvFile!.path.split('/').last}'
                        : 'Upload CV',
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
                    'Experience Letter',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              TextButton(
                  onPressed: () {
                    pickFile((file) => _experienceLetterFile = file);
                  },
                  child: Text(
                    _experienceLetterFile != null
                        ? 'Experience Letter: ${_experienceLetterFile!.path.split('/').last}'
                        : 'Upload Experience Letter',
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
                    'Result Card',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              TextButton(
                  onPressed: () {
                    pickFile((file) => _resultCardFile = file);
                  },
                  child: Text(
                    _resultCardFile != null
                        ? 'Result Card: ${_resultCardFile!.path.split('/').last}'
                        : 'Upload Result Card',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        decoration: TextDecoration.underline),
                  )),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Current Role',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              customizedTextField(
                width: 360,
                readOnly: true,
                hintText: 'Select Role',
                controller: roleController,
                dropDownItems: role,
              ),
              SizedBox(
                height: media.height * 0.02,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Software Development',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              customizedTextField(
                width: 360,
                readOnly: true,
                hintText: 'Select Development',
                controller: developmentController,
                dropDownItems: development,
              ),
              SizedBox(
                height: media.height * 0.02,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Date of Joining',
                    style: GoogleFonts.oswald(fontWeight: FontWeight.w600),
                  )),
              DatePickerField(controller: dateOfJoining),
              GestureDetector(
                  onTap: () {
                    print(developmentController.toString());
                    print(_cvFile.toString());
                    print(dateOfJoining.toString());
                  },
                  child: GradientButton(ButtonTitle: 'Next >')),
              SizedBox(
                height: media.height * 0.02,
              ),
            ],
          ),
        ),
      )),
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

  void checkValue() {
    try {
      String role = roleController.text.trim();
      String development = developmentController.text.trim();
      String joiningDate = dateOfJoining.text.trim();
      if (role == "" ||
          development == "" ||
          joiningDate == "" ||
          _image == null ||
          _cvFile == null ||
          _experienceLetterFile == null ||
          _resultCardFile == null) {
        showMessage.errorToastMessage('Please Fill all the requirements');
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  void uploadDate() async {
    try {
      final String uid = widget.userModel.userId.toString();
      final uploadImage = await FirebaseStorage.instance
          .ref('profilePictures')
          .child(uid)
          .putFile(_image!);
      TaskSnapshot imageShot = await uploadImage;
      String imageUrl = await imageShot.ref.getDownloadURL();

      final uploadCv = await FirebaseStorage.instance
          .ref('cvFiles')
          .child('$uid-cv')
          .putFile(_cvFile!);
      TaskSnapshot cvSnapshot = await uploadCv;
      String cvUrl = await cvSnapshot.ref.getDownloadURL();

      final uploadExperienceLetter = await FirebaseStorage.instance
          .ref('experienceLetters')
          .child('$uid-experienceLetters.pdf')
          .putFile(_experienceLetterFile!);
      TaskSnapshot experienceLetterSnapshot = await uploadExperienceLetter;
      String experienceLetterUrl =
          await experienceLetterSnapshot.ref.getDownloadURL();

      final uploadResult = await FirebaseStorage.instance
          .ref('resultFiles')
          .child('$uid-resultFiles')
          .putFile(_resultCardFile!);
      TaskSnapshot resultSnapshot = await uploadResult;
      String resultUrl = await resultSnapshot.ref.getDownloadURL();
      String role = roleController.toString();
      String development = developmentController.toString();
      String dateofJoining = dateOfJoining.toString();
      widget.userModel.profileImage = imageUrl.toString();
      widget.userModel.cvUrl = cvUrl.toString();
      widget.userModel.experienceLetterUrl = experienceLetterUrl.toString();
      widget.userModel.resultCardUrl = resultUrl.toString();
      widget.userModel.role = role.toString();
      widget.userModel.carrier = development.toString();
      widget.userModel.joiningDate = dateofJoining.toString();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userModel.userId)
          .set(widget.userModel.toMap())
          .then(
            (value) => {
              showMessage.ToastMessage('New User Created'),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationScreen(),
                  ))
            },
          );
    } catch (e) {
      print(e.toString());
    }
  }
}
