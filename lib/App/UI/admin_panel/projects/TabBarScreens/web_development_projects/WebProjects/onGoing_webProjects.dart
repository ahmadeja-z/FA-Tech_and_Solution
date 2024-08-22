import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class OnGoingWebProjects extends StatefulWidget {
  const OnGoingWebProjects({super.key});

  @override
  State<OnGoingWebProjects> createState() => _OnGoingWebProjectsState();
}

class _OnGoingWebProjectsState extends State<OnGoingWebProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ongoing Web Development Projects',style: TextStyle(fontFamily: 'Lato',fontSize: 20),),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType: 'Web Development',statusType: 'ongoing',),
    );
  }
}
