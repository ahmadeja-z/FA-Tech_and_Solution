import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class FlutterFlowProjects extends StatefulWidget {
  const FlutterFlowProjects({super.key});

  @override
  State<FlutterFlowProjects> createState() => _FlutterFlowProjectsState();
}

class _FlutterFlowProjectsState extends State<FlutterFlowProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutterflow Projects'),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType: 'Flutterflow'),
    );
  }
}
