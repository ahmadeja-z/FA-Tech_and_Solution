import 'package:flutter/material.dart';

class UiHelper {
  static void showLoadingAlert(String title, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showErrorDialog(String title, String content, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          content: Text(
            content,
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Ok',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            ),
          ],
        );
      },
    );
  }
}
