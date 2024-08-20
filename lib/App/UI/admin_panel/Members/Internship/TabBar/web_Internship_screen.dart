import 'package:flutter/material.dart';

import '../../../../../Services/FirebaseDataGetter.dart'; // Import the widget

class WebIntern extends StatelessWidget {
  const WebIntern({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Development'),automaticallyImplyLeading: false,
      ),
      body: UserListWidget(
        role: 'role',
        whichRole: 'Intern',
        emptyMessage: 'There are no Web development interne present',
        career: 'carrier',
        whichCareer: 'Web Development',
      ),
    );
  }
}
