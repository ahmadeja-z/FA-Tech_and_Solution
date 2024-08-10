import 'package:fasolution/App/UI/Autentication/Login.dart';
import 'package:fasolution/App/UI/Autentication/SignUp/SignUp.dart';
import 'package:fasolution/App/UI/NavBar/Attendence/AttendencePage.dart';
import 'package:fasolution/App/UI/NavBar/Profile/Profile.dart';
import 'package:fasolution/App/UI/OnBoarding/onBoarding.dart';
import 'package:fasolution/App/UI/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'App/Model/Model/UserModel.dart';
import 'App/UI/Autentication/SignUp/CompleteProfile.dart';
import 'App/UI/NavBar/Announsments/Announsments.dart';
import 'App/UI/NavBar/Home/Home.dart';
import 'App/UI/NavBar/NavScreen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => {print('Succesfully')},).onError((error, stackTrace) => {print('Erorrrrrrrrrrrrr${error}')},);
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

      home: LoginScreen() ,
    );
  }
}

