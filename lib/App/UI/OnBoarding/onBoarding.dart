
import 'package:fasolution/App/UI/Autentication/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Model/ViewModel/onBoardingScreenModel.dart';
import '../../Resources/Color.dart';
class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  late PageController controller;
  int selectPage = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController();
    controller.addListener(() {
      setState(() {
        selectPage = controller.page?.round() ?? 0;
      });
    });
  }

  var arrScreen = [
    {
      'title': 'WEB DEVELOPMENT',
      'subtitle':
      'Web development involves HTML for structure, CSS for styling, JavaScript for interactivity, and frameworks like React, Angular, and Vue for building dynamic, responsive user interfaces, plus backend technologies for server-side logic.',
      'image': 'assets/images/1.png'
    },
    {
      'title': 'APP DEVELOPMENT',
      'subtitle':
      'App development involves using languages like Swift for iOS, Kotlin for Android, Flutter for cross-platform apps, and tools like Xcode and Android Studio for building, testing, and deploying applications.',
      'image': 'assets/images/2.png'
    },
    {
      'title': 'UI / UX',
      'subtitle':
      'UI/UX design involves using tools like Adobe XD, Sketch, and Figma for creating user interfaces, conducting user research and testing, and ensuring intuitive, aesthetically pleasing, and user-friendly experiences.',
      'image':'assets/images/3.png'
    },

  ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              itemCount: arrScreen.length,
              controller: controller,
              itemBuilder: (context, index) {
                var Mobj = arrScreen[index] as Map? ?? {};
                return onBoardingPageModel(Mobj: Mobj);
              }),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                print('hello');
                if (selectPage < 2) {
                  selectPage = selectPage + 1;
                  controller.animateToPage(selectPage,
                      duration: Duration(milliseconds: 600),
                      curve: Curves.easeOut);
                  setState(() {});
                } else {
                  print('Welcome to Screen');
Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));                }

                setState(() {});
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin:
                    EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: FColor.primaryColor1,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.arrow_forward_ios_outlined,
                        color: Colors.white, size: 30),
                  ),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(
                      color: FColor.primaryColor1,
                      strokeWidth: 2, // Adjust the stroke width as needed
                      value: (selectPage + 1) / 3,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
