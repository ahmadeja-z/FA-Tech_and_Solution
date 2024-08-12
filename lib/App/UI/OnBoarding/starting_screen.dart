import 'dart:async';
import 'package:fasolution/App/UI/OnBoarding/onBoarding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Resources/Color.dart';
import '../../Resources/Components/GradientText.dart';


class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isColorChange = false;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {
      setState(() {
        isColorChange = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Container(
        height: media.height,
        width: media.width,
        decoration: BoxDecoration(
          gradient: isColorChange
              ? LinearGradient(
            colors: FColor.PrimaryGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
        ),
        child: Column(
          children: [
            SizedBox(height: media.height * 0.35),
            Image.asset('assets/images/logo.png', height: 200, width: 200,),

            Spacer(),
            isColorChange ? InkWell(
              onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => BoardingScreen(),));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                height: 60,
                width: 315,
                decoration: isColorChange
                    ? BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: FColor.white,
                )
                    : BoxDecoration(
                  gradient: LinearGradient(
                    colors: FColor.PrimaryGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: GradientText(
                    text: 'Get Started',
                    gradient: LinearGradient(
                      colors: isColorChange
                          ? FColor.PrimaryGradient
                          : [Colors.white, Colors.white],
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ) : Padding(
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