import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class WebDevelopmentProjects extends StatefulWidget {
  const WebDevelopmentProjects({super.key});

  @override
  State<WebDevelopmentProjects> createState() => _WebDevelopmentProjectsState();
}

class _WebDevelopmentProjectsState extends State<WebDevelopmentProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Web Development Projects'),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType: 'Web Development'),
    );
  }
}
