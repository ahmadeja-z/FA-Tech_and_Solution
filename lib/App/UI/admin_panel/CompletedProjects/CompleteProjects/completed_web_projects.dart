import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class CompletedWebProjects extends StatefulWidget {
  const CompletedWebProjects({super.key});

  @override
  State<CompletedWebProjects> createState() => _CompletedWebProjectsState();
}

class _CompletedWebProjectsState extends State<CompletedWebProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Completed Web Projects',style: TextStyle(fontFamily: 'Lato',fontSize: 20),),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType:
      'Web Development'
        ,statusType: 'completed',),
    );
  }
}
