import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomSnackbar {
  static void show({
    required BuildContext context,
    required String title,
    Color backgroundColor = Colors.black, // Default background color
    Color textColor = Colors.white, // Default text color
  }) {
    final snackBar = SnackBar(
      content: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: EdgeInsets.all(16),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
class showMessage{
  static void errorToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red, // Example color
      gravity: ToastGravity.CENTER,
      textColor: Colors.black,
    );
  }
  static void ToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.blue, // Example color
      gravity: ToastGravity.CENTER,
      textColor: Colors.black,
    );
  }
}
