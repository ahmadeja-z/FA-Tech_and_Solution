import 'package:flutter/material.dart';

import '../../../../Services/FirebaseDataGetter.dart'; // Import the widget

class WebEmployees extends StatelessWidget {
  const WebEmployees({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Development'),
        automaticallyImplyLeading: false,
      ),
      body: UserListWidget(
        role: 'role',
        whichRole: 'Employee',
        emptyMessage: 'There are no Web development interne present',
        career: 'carrier',
        whichCareer: 'Web Development',
      ),
    );
  }
}
