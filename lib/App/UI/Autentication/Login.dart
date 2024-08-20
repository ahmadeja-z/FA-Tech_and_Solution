import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:fasolution/App/Resources/Color.dart';
import 'package:fasolution/App/UI/Autentication/SignUp/SignUp.dart';
import 'package:fasolution/App/UI/NavBar/nav_screen.dart';
import 'package:fasolution/App/UI/admin_panel/admin_navigation.dart';
import 'package:fasolution/App/Utils/ShowMessage/StatusBars.dart';
import 'package:fasolution/App/Utils/ShowMessage/Ui%20Helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Resources/Components/CustomizedTextField.dart';
import '../../Resources/Components/GradientButton.dart';
import '../../Resources/Components/GradientText.dart';

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

  String selectedRole = 'User';

  // Predefined admin credentials
  final String adminEmail = 'ahmad@gmail.com';
  final String adminPassword = 'admin123'; // Set your admin password here

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
                            ),
                          ),
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
                            borderSide: BorderSide(color: FColor.GreyBrown),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                            const BorderSide(color: Color(0xFFF7F8F8)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: media.height * 0.02,
                ),
                // Role selection dropdown
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 100,
                    child: DropdownButtonFormField<String>(
                      style: TextStyle(
                          fontFamily: 'Lato', color: Colors.black),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      value: selectedRole,
                      items: ['User', 'Admin'].map((String role) {
                        return DropdownMenuItem<String>(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedRole = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Role',
                        labelStyle: TextStyle(
                          fontFamily: 'Lato',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(width: 0),
                        ),
                      ),
                    ),
                  ),
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
                  child: const GradientButton(ButtonTitle: 'Login'),
                ),
                SizedBox(
                  height: media.height * 0.1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account yet?',
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
                          ),
                        );
                      },
                      child: GradientText(
                        text: ' Register',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins'),
                        gradient: LinearGradient(
                          colors: FColor.SecondaryGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
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
    // Check if the selected role is Admin and credentials match
    if (email == adminEmail && password == adminPassword && selectedRole == 'Admin') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminPanelScreen(),
        ),
      );
      return;
    }

    // Show a loading dialog while authentication is in progress
    UiHelper.showLoadingAlert('Logging in...', context);

    try {
      // Firebase authentication
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Retrieve user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      if (!userDoc.exists || userDoc.data() == null) {
        // Handle case where user data does not exist
        throw FirebaseAuthException(
          message: 'User data not found in Firestore.',
          code: 'user-not-found',
        );
      }

      // Parse user data into UserModel
      UserModel userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);

      // Clear input fields
      _emailController.clear();
      _passwordController.clear();

      // Close the loading dialog
      Navigator.of(context).pop();

      // Navigate based on the selected role
      if (selectedRole == 'User') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationScreen(
              userModel: userModel,
              user: credential.user!,
            ),
          ),
        );
      } else {
        // Handle invalid role selection for non-admin users
        UiHelper.showErrorDialog('Invalid Role', 'Please select the correct role.', context);
      }
    } on FirebaseAuthException catch (e) {
      // Close the loading dialog
      Navigator.pop(context);

      // Display appropriate error messages based on Firebase exception code
      switch (e.code) {
        case 'user-not-found':
          UiHelper.showErrorDialog('Login Failed', 'No user found for that email.', context);
          break;
        case 'wrong-password':
          UiHelper.showErrorDialog('Login Failed', 'Incorrect password provided.', context);
          break;
        default:
          UiHelper.showErrorDialog('Login Failed', e.message!, context);
          break;
      }
    } catch (e) {
      // Handle unexpected errors
      Navigator.pop(context);
      UiHelper.showErrorDialog('Unexpected Error', e.toString(), context);
    }
  }

}
