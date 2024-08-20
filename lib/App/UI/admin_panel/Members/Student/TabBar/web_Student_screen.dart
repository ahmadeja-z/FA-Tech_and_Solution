import 'package:flutter/material.dart';

import '../../../../../Services/FirebaseDataGetter.dart'; // Import the widget

class WebStudent extends StatelessWidget {
  const WebStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Text('Web Development'),
      ),
      body: UserListWidget(
        role: 'role',
        whichRole: 'Student',
        emptyMessage: 'There are no Web development interne present',
        career: 'carrier',
        whichCareer: 'Web Development',
      ),
    );
  }
}
