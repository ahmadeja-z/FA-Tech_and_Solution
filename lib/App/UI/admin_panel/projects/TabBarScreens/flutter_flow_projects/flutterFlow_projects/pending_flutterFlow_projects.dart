import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class PendingFlutterFlowProjects extends StatefulWidget {
  const PendingFlutterFlowProjects({super.key});

  @override
  State<PendingFlutterFlowProjects> createState() => _PendingFlutterFlowProjectsState();
}

class _PendingFlutterFlowProjectsState extends State<PendingFlutterFlowProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pending FlutterFlow Projects'),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType: 'FlutterFlow',statusType: 'pending',),
    );
  }
}
