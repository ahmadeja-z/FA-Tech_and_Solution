import 'package:flutter/material.dart';

import '../../../../../Services/FirebaseDataGetter.dart'; // Import the widget

class FlutterFlowStudent extends StatelessWidget {
  const FlutterFlowStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Flow'),automaticallyImplyLeading: false,
      ),
      body: UserListWidget(
        role: 'role',
        whichRole: 'Student',
        emptyMessage: 'There are no FlutterFlow Student present',
        career: 'carrier',
        whichCareer: 'Flutter Flow',
      ),
    );
  }
}
