import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:fasolution/App/Resources/Color.dart';
import 'package:fasolution/App/UI/Autentication/SignUp/SignUp.dart';
import 'package:fasolution/App/UI/NavBar/nav_screen.dart';
import 'package:fasolution/App/Utils/ShowMessage/StatusBars.dart';
import 'package:fasolution/App/Utils/ShowMessage/Ui%20Helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Resources/Components/CustomizedTextField.dart';
import '../../Resources/Components/GradientButton.dart';
import '../../Resources/Components/GradientText.dart';
import '../../Utils/Utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  ValueNotifier<bool> Obscure = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: media.height * 0.03,
              ),
              const Text(
                'Hey there,',
                style: TextStyle(
                    color: Color(0xFF1D1617),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    fontFamily: 'Poppins'),
              ),
              const Text(
                'Welcome Back',
                style: TextStyle(
                    color: Color(0xFF1D1617),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: media.height * .1,
              ),
              customizedTextField(
                controller: _emailController,
                prefixIcon: Icon(
                  CupertinoIcons.person,
                  color: FColor.GreyBrown,
                ),
                hintText: 'User Name',
                keyboardType: TextInputType.emailAddress,
                currentFocus: _emailFocus,
                nextFocus: _passwordNode,
              ),
              SizedBox(
                height: media.height * 0.02,
              ),
              ValueListenableBuilder(
                valueListenable: Obscure,
                builder: (context, val, child) {
                  return SizedBox(
                    height: 45,
                    width: 320,
                    child: TextField(
                      controller: _passwordController,
                      focusNode: _passwordNode,
                      cursorColor: const Color(0xFFADA4A5),
                      obscureText: val,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 1),
                          suffixIcon: GestureDetector(
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
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFADA4A5),
                            fontFamily: 'Poppins',
                          ),
                          fillColor: const Color(0xFFF7F8F8),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(color: FColor.GreyBrown)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  const BorderSide(color: Color(0xFFF7F8F8)))),
                    ),
                  );
                },
              ),
              SizedBox(
                height: media.height * 0.05,
              ),
              const Text(
                'Forget your password?',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    decoration: TextDecoration.underline),
              ),
              SizedBox(
                height: media.height * .26,
              ),
              GestureDetector(
                  onTap: () {
                    checkController(context);
                  },
                  child: const GradientButton(ButtonTitle: 'Login')),
              SizedBox(
                height: media.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont\'t have an account yet?',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal,
                        fontSize: 13),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp_View(),
                            ));
                      },
                      child: GradientText(
                          text: ' Register',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                          gradient: LinearGradient(
                              colors: FColor.SecondaryGradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  void checkController(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      UiHelper.showErrorDialog('Requirements', 'Fill all the requirements', context);
    } else {
      login(email, password, context);
    }
  }

  void login(String email, String password, BuildContext context) async {
    UiHelper.showLoadingAlert('Login...', context);
    UserCredential? credential;

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
UiHelper.showErrorDialog('Exception', e.toString(), context);
      print('Sign-in failed: $e');
      return; // Early return if sign-in fails
    }

    if (credential != null) {
      String userUid = credential.user!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userUid)
          .get();

      // Debug statement to print the fetched document data
      print('Fetched document data: ${userDoc.data()}');

      // Check if the document exists and contains data
      if (userDoc.exists && userDoc.data() != null) {
        UserModel userModel =
            UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

        // Print the user model data for debugging
        print('User model created: $userModel');

        // Clear the text controllers
        _emailController.clear();
        _passwordController.clear();

        // Navigate to the next screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationScreen(
              userModel: userModel,
              user: credential!.user!,
            ),
          ),
        );
      } else {
        // Handle case where user document is not found
        UiHelper.showErrorDialog('Exception',"User data not found in Firestore.",context);
        print('User data not found in Firestore.');
      }
    }
  }
}
