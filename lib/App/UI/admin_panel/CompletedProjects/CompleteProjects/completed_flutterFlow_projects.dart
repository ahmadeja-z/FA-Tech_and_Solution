import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class CompletedFlutterFlowProjects extends StatefulWidget {
  const CompletedFlutterFlowProjects({super.key});

  @override
  State<CompletedFlutterFlowProjects> createState() => _CompletedFlutterFlowProjectsState();
}

class _CompletedFlutterFlowProjectsState extends State<CompletedFlutterFlowProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed FlutterFlow Projects',style: TextStyle(fontFamily: 'Lato',fontSize: 20),),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType:
      'FlutterFlow'
        ,statusType: 'completed',),
    );
  }
}
