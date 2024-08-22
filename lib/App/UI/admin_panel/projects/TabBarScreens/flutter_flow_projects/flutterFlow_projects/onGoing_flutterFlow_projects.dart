import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class OnGoingFlutterFlowProjects extends StatefulWidget {
  const OnGoingFlutterFlowProjects({super.key});

  @override
  State<OnGoingFlutterFlowProjects> createState() => _OnGoingFlutterFlowProjectsState();
}

class _OnGoingFlutterFlowProjectsState extends State<OnGoingFlutterFlowProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ongoing FlutterFlow Projects',style: TextStyle(fontFamily: 'Lato',fontSize: 20),),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType: 'FlutterFlow'
        ,statusType: 'ongoing',),
    );
  }
}
