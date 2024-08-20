import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class FlutterProjects extends StatefulWidget {
  const FlutterProjects({super.key});

  @override
  State<FlutterProjects> createState() => _FlutterProjectsState();
}

class _FlutterProjectsState extends State<FlutterProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Projects'),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType: 'Flutter'),
    );
  }
}
