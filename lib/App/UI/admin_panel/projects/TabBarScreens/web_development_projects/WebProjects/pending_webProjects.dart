import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class PendingWebProjects extends StatefulWidget {
  const PendingWebProjects({super.key});

  @override
  State<PendingWebProjects> createState() => _PendingWebProjectsState();
}

class _PendingWebProjectsState extends State<PendingWebProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pending Web Development Projects',style: TextStyle(fontSize: 20,fontFamily: 'Lato'),),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType: 'Web Development',statusType: 'pending',),
    );
  }
}
