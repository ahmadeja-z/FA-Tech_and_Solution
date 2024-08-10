
import 'package:fasolution/App/Resources/Color.dart';
import 'package:fasolution/App/UI/Autentication/SignUp/SignUp.dart';
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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _nameFocus = FocusNode();
  FocusNode _passwordNode = FocusNode();
  ValueNotifier<bool> Obscure = ValueNotifier<bool>(true);

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
                    height: media.height * 0.03,
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
                    controller: _nameController,
                    prefixIcon: Icon(
                      CupertinoIcons.person,
                      color: FColor.GreyBrown,
                    ),
                    hintText: 'User Name',
                    keyboardType: TextInputType.emailAddress,
                   currentFocus : _nameFocus,
            
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
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFADA4A5),
                                fontFamily: 'Poppins',
                              ),
                              fillColor: Color(0xFFF7F8F8),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: FColor.GreyBrown)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Color(0xFFF7F8F8)))),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: media.height * 0.05,
                  ),
                  Text(
                    'Forget your password?',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        decoration: TextDecoration.underline),
                  ),
                  SizedBox(
                    height: media.height * .26,
                  ),
                  GradientButton(ButtonTitle: 'Login'),
                  SizedBox(height: media.height*0.1,),
            
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont\'t have an account yet?',style: TextStyle(fontFamily: 'Poppins',fontWeight: FontWeight.normal,fontSize: 13),),
                      GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp_View(),));
            
                          },
                          child: GradientText(text: ' Register',style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'Poppins'), gradient: LinearGradient(colors: FColor.SecondaryGradient,begin: Alignment.topLeft,end: Alignment.bottomRight)))
                    ],
                  )
            
            
                ],
              ),
            ),
          )),
    );
  }
}
