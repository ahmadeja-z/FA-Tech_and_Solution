import 'dart:async';
import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:fasolution/App/Services/FirebaseHelper.dart';
import 'package:fasolution/App/UI/NavBar/nav_screen.dart';
import 'package:fasolution/App/UI/OnBoarding/starting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashController {
  void isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser;

    if (currentUser != null) {
      UserModel? userModel = await FirebaseHelper.getInfo(currentUser.uid);

      if (userModel != null && context.mounted) {
        await Future.delayed(Duration(seconds: 2));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NavigationScreen(userModel: userModel, user: currentUser),
          ),
        );
      }
    } else {
      await Future.delayed(Duration(seconds: 2));

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => StartingScreen(),
          ),
        );
      }
    }
  }
}
