import 'package:fasolution/App/Resources/Color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Resources/Components/AppBar2.dart';

class FileViewer extends StatelessWidget {
  final String fileUrl;
  final String title;

  FileViewer({required this.fileUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizableAppBar(
        title: title,
        leadingIcon: Icon(CupertinoIcons.back),
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(color: FColor.primaryColor1,),
            Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.grey, spreadRadius: 30, blurRadius: 22)
                ]),
                child: Image(
                    image: NetworkImage(
                  fileUrl.toString(),
                ))),
          ],
        ),
      ),
    );
  }
}
