import 'package:flutter/material.dart';

import '../../../../Services/FirebaseDataGetter.dart'; // Import the widget

class FlutterStudent extends StatelessWidget {
  const FlutterStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Development'),automaticallyImplyLeading: false,
      ),
      body: UserListWidget(
        role: 'role',
        whichRole: 'Student',
        emptyMessage: 'There are no Flutter Development student present',
        career: 'carrier',
        whichCareer: "Flutter Development",
      ),
    );
  }
}
