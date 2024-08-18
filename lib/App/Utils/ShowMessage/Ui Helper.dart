import 'package:fasolution/App/Utils/ShowMessage/StatusBars.dart';
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

  static void showErrorDialog(
      String title, String content, BuildContext context) {
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

  static void showOptionDialog(String Title, String Description,
      VoidCallback onOk, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: onOk,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text('Delete'))),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('cancel'))
            ],
            title: Text(
              Title,
              style: TextStyle(fontFamily: 'Poppins'),
            ),
            content: Text(
              Description,
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          );
        });
  }
}
