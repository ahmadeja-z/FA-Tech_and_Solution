import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class CompletedFlutterProjects extends StatefulWidget {
  const CompletedFlutterProjects({super.key});

  @override
  State<CompletedFlutterProjects> createState() => _CompletedFlutterProjectsState();
}

class _CompletedFlutterProjectsState extends State<CompletedFlutterProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Flutter Projects',style: TextStyle(fontFamily: 'Lato',fontSize: 20),),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType:
      'Flutter'
        ,statusType: 'completed',),
    );
  }
}
