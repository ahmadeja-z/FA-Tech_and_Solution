import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class PendingFlutterProjects extends StatefulWidget {
  const PendingFlutterProjects({super.key});

  @override
  State<PendingFlutterProjects> createState() => _PendingFlutterProjectsState();
}

class _PendingFlutterProjectsState extends State<PendingFlutterProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pending Flutter Projects',style: TextStyle(fontSize: 20,fontFamily: 'Lato'),),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType: 'Flutter',statusType: 'pending',),
    );
  }
}
