import 'dart:async';
import 'package:fasolution/App/Controller/splashScreenController.dart';
import 'package:fasolution/App/UI/OnBoarding/onBoarding.dart';
import 'package:flutter/material.dart';

import '../Resources/Color.dart';
import '../Resources/Components/GradientText.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  SplashController _controller = SplashController();
  void initState() {
    super.initState();
    _controller.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: media.height * 0.35),
            Image.asset(
              'assets/images/logo.png',
              height: 200,
              width: 200,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: CircularProgressIndicator(
                color: FColor.primaryColor1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
