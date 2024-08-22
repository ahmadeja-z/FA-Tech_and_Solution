import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Services/firebase_dataGetter_projects.dart';
import 'package:flutter/material.dart';

class OnGoingFlutterProjects extends StatefulWidget {
  const OnGoingFlutterProjects({super.key});

  @override
  State<OnGoingFlutterProjects> createState() => _OnGoingFlutterProjectsState();
}

class _OnGoingFlutterProjectsState extends State<OnGoingFlutterProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OnGoing Flutter Projects',style: TextStyle(fontFamily: 'Lato',fontSize: 20),),automaticallyImplyLeading: false,),
      body: AssignedProject(roleType: 'Flutter',statusType: '',),
    );
  }
}
