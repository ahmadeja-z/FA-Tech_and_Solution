import 'package:flutter/material.dart';

import '../../../../Services/FirebaseDataGetter.dart'; // Import the widget

class FlutterIntern extends StatelessWidget {
  const FlutterIntern({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Development'),automaticallyImplyLeading: false,
      ),
      body: UserListWidget(
        role: 'role',
        whichRole: 'Intern',
        emptyMessage: 'There are no Flutter Development interne present',
        career: 'carrier',
        whichCareer: "Flutter Development",
      ),
    );
  }
}
