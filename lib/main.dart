import 'package:fasolution/App/UI/Autentication/Login.dart';
import 'package:fasolution/App/UI/Autentication/SignUp/SignUp.dart';
import 'package:fasolution/App/UI/NavBar/Attendence/AttendencePage.dart';
import 'package:fasolution/App/UI/NavBar/Home/detail_person_info.dart';
import 'package:fasolution/App/UI/NavBar/Profile/FileViewer.dart';
import 'package:fasolution/App/UI/NavBar/Profile/Profile.dart';
import 'package:fasolution/App/UI/OnBoarding/onBoarding.dart';
import 'package:fasolution/App/UI/OnBoarding/starting_screen.dart';
import 'package:fasolution/App/UI/admin_panel/admin_navigation.dart';
import 'package:fasolution/App/UI/app_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';
import 'App/Model/Model/UserModel.dart';
import 'App/UI/Autentication/SignUp/CompleteProfile.dart';
import 'App/UI/NavBar/Announsments/Announsments.dart';
import 'App/UI/NavBar/Home/people_info.dart';
import 'App/UI/NavBar/nav_screen.dart';
import 'App/UI/admin_panel/Memebers/members.dart';
import 'firebase_options.dart';
var uid=Uuid();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  )
      .then(
        (value) => {print('Succesfully')},
      )
      .onError(
        (error, stackTrace) => {print('Erorrrrrrrrrrrrr${error}')},
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: AdminPanelScreen(),
    );
  }
}
