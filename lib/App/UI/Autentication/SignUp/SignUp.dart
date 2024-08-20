import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:fasolution/App/UI/Autentication/Login.dart';
import 'package:fasolution/App/UI/Autentication/SignUp/CompleteProfile.dart';
import 'package:fasolution/App/Utils/ShowMessage/StatusBars.dart';
import 'package:fasolution/App/Utils/ShowMessage/Ui%20Helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Resources/Color.dart';
import '../../../Resources/Components/CustomizedTextField.dart';
import '../../../Resources/Components/GradientButton.dart';
import '../../../Resources/Components/GradientText.dart';

class SignUp_View extends StatefulWidget {
  SignUp_View({super.key});

  @override
  State<SignUp_View> createState() => _SignUp_ViewState();
}

class _SignUp_ViewState extends State<SignUp_View> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _surNameController = TextEditingController();
  FocusNode _emailNode = FocusNode();
  FocusNode _passwordNode = FocusNode();
  FocusNode _cPasswordNode = FocusNode();
  FocusNode _nameNode = FocusNode();
  FocusNode _surNameNode = FocusNode();
  ValueNotifier<bool> Obscure = ValueNotifier<bool>(true);
  ValueNotifier<bool> CObscure = ValueNotifier<bool>(true);
  bool CheckTick = false;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: media.height * 0.05,
                ),
                Text(
                  'Hey there,',
                  style: TextStyle(
                      color: Color(0xFF1D1617),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Poppins'),
                ),
                Text(
                  'Create an Account',
                  style: TextStyle(
                      color: Color(0xFF1D1617),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(
                  height: media.height * .07,
                ),
                SizedBox(height: media.height * 0.01),
                customizedTextField(
                  controller: _nameController,
                  currentFocus: _nameNode,
                  nextFocus: _surNameNode,
                  prefixIcon: Icon(
                    Icons.person_3_outlined,
                    color: FColor.GreyBrown,
                  ),
                  hintText: 'First Name',
                ),
                SizedBox(
                  height: media.height * 0.02,
                ),
                customizedTextField(
                  controller: _surNameController,
                  currentFocus: _surNameNode,
                  nextFocus: _emailNode,
                  prefixIcon: Icon(
                    Icons.person_3_outlined,
                    color: FColor.GreyBrown,
                  ),
                  hintText: 'Sur Name',
                ),
                SizedBox(
                  height: media.height * 0.02,
                ),
                customizedTextField(
                  controller: _emailController,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: FColor.GreyBrown,
                  ),
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  currentFocus: _emailNode,
                  nextFocus: _passwordNode,
                ),
                SizedBox(
                  height: media.height * 0.02,
                ),
                ValueListenableBuilder(
                  valueListenable: Obscure,
                  builder: (context, valu, child) {
                    return SizedBox(
                      height: 45,
                      width: 320,
                      child: TextField(
                        controller: _passwordController,
                        focusNode: _passwordNode,
                        cursorColor: Color(0xFFADA4A5),
                        obscureText: valu,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 1),
                            suffixIcon: InkWell(
                                onTap: () {
                                  Obscure.value = !Obscure.value;
                                },
                                child: Obscure.value
                                    ? Icon(
                                        Icons.visibility_outlined,
                                        color: FColor.GreyBrown,
                                      )
                                    : Icon(
                                        Icons.visibility_off_outlined,
                                        color: FColor.GreyBrown,
                                      )),
                            prefixIcon: Icon(
                              Icons.lock_outlined,
                              color: FColor.GreyBrown,
                            ),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFADA4A5),
                              fontFamily: 'Poppins',
                            ),
                            fillColor: Color(0xFFF7F8F8),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: FColor.GreyBrown)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Color(0xFFF7F8F8)))),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: media.height * 0.02,
                ),
                ValueListenableBuilder(
                  valueListenable: CObscure,
                  builder: (context, val, child) {
                    return SizedBox(
                      height: 45,
                      width: 320,
                      child: TextField(
                        controller: _cPasswordController,
                        focusNode: _cPasswordNode,
                        cursorColor: Color(0xFFADA4A5),
                        obscureText: val,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 1),
                            suffixIcon: InkWell(
                                onTap: () {
                                  CObscure.value = !CObscure.value;
                                },
                                child: CObscure.value
                                    ? Icon(
                                        Icons.visibility_outlined,
                                        color: FColor.GreyBrown,
                                      )
                                    : Icon(
                                        Icons.visibility_off_outlined,
                                        color: FColor.GreyBrown,
                                      )),
                            prefixIcon: Icon(
                              Icons.lock_outlined,
                              color: FColor.GreyBrown,
                            ),
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFADA4A5),
                              fontFamily: 'Poppins',
                            ),
                            fillColor: Color(0xFFF7F8F8),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: FColor.GreyBrown)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide:
                                    BorderSide(color: Color(0xFFF7F8F8)))),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: media.height * 0.05,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          CheckTick = !CheckTick;
                        });
                        print(CheckTick.toString());
                      },
                      child: CheckTick
                          ? Icon(
                              Icons.check_box_rounded,
                              color: Colors.blue,
                            )
                          : Icon(Icons.check_box_outline_blank_rounded),
                    ),
                    SizedBox(width: media.width * 0.02),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          color: Colors.black, // Default text color
                        ),
                        children: [
                          TextSpan(
                            text: 'By continuing you accept our ',
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle tap on "Privacy Policy"
                              },
                          ),
                          TextSpan(
                            text: ' and\n',
                          ),
                          TextSpan(
                            text: 'Term of Use',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('tapped');
                                // Handle tap on "Term of Use"
                              },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: media.height * .1,
                ),
                GestureDetector(
                    onTap: () {
                      checkController(
                        _nameController.toString(),
                        _surNameController.toString(),
                        _emailController.toString(),
                        _passwordController.toString(),
                        _cPasswordController.toString(),
                      );
                    },
                    child: GradientButton(ButtonTitle: 'Register')),
                SizedBox(
                  height: media.height * .03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account!',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal,
                          fontSize: 13),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ));
                      },
                      child: GradientText(
                          text: ' Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                          gradient: LinearGradient(
                              colors: FColor.SecondaryGradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkController(String name, String surName, String email,
      String password, String cPassword) {
    name = _nameController.text.trim();
    surName = _surNameController.text.trim();
    email = _emailController.text.trim();
    password = _passwordController.text.trim();
    cPassword = _cPasswordController.text.trim();
    if (name.isEmpty ||
        surName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        cPassword.isEmpty) {
      UiHelper.showErrorDialog(
          'Requirements', 'Fill all the requirements', context);
    } else if (password != cPassword) {
      UiHelper.showErrorDialog(
          'Password Error', 'Passwords are not matched', context);
    } else {
      signUp(name, surName, email, password);
    }
  }

  void signUp(
      String name, String surName, String email, String password) async {
    UserCredential? credential;
    UiHelper.showLoadingAlert('Sign...', context);

    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      print(ex.toString());
      UiHelper.showErrorDialog('Exception', ex.toString(), context);
    }
    if (credential != null) {
      String uid = credential.user!.uid.toString();
      UserModel _userModel = UserModel(
        userId: uid,
        name: name,
        surName: surName,
        email: email,
        attendance: null,
        carrier: '',
        role: '',
        joiningDate: null,
        completedProjects: null,
        ongoingProjects: null,
        profilePictureUrl: '',
        experienceLetterUrl: '',
        cvUrl: '',
        resultCardUrl: '',
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(_userModel.toMap())
          .then(
        (value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CompleteProfile(
                  FirebaseUser: credential!.user!,
                  userModel: _userModel,
                ),
              ));
        },
      ).onError(
        (error, stackTrace) {
          Navigator.pop(context);
          UiHelper.showErrorDialog('Exception', error.toString(), context);
        },
      );
    }
  }
}
