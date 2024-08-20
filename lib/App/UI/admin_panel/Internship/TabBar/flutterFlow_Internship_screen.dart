import 'package:flutter/material.dart';

import '../../../../Services/FirebaseDataGetter.dart'; // Import the widget

class FlutterFlowIntern extends StatelessWidget {
  const FlutterFlowIntern({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Flow'),automaticallyImplyLeading: false,
      ),
      body: UserListWidget(
        role: 'role',
        whichRole: 'Intern',
        emptyMessage: 'There are no Web development interne present',
        career: 'carrier',
        whichCareer: 'Flutter Flow',
      ),
    );
  }
}
