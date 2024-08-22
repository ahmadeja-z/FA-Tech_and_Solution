import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:fasolution/App/Resources/Components/deleteButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Resources/Color.dart';
import '../../../Resources/Components/DetailPerson.dart';

class DetailProfileInfo extends StatefulWidget {
  DetailProfileInfo(
      {super.key,
      required this.name,
      required this.surName,
      required this.profileImage,
      required this.carrier,
      required this.joiningDate,
      required this.role,
      required this.attendance,
      required this.email,
      this.OnDelete,
      this.OnAssign});
  final String name;
  final String surName;
  final String email;
  final String profileImage;
  final String carrier;
  final String joiningDate;
  final String role;
  final String attendance;
  final VoidCallback? OnDelete;
  final VoidCallback? OnAssign;

  @override
  State<DetailProfileInfo> createState() => _DetailProfileInfoState();
}

class _DetailProfileInfoState extends State<DetailProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizableAppBar(
        title: 'Pending',
        leadingIcon: Icon(
          CupertinoIcons.back,
          color: Colors.white,
        ),
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(widget.profileImage),
            ),
            SizedBox(height: 20),

            // Name and Email
            Text(
              widget.name,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: FColor.primaryColor1,
              ),
            ),

            SizedBox(height: 10),
            Text(
              widget.email,
              style: TextStyle(
                fontSize: 18,
                color: FColor.GreyBrown,
              ),
            ),
            SizedBox(height: 30),

            buildInfoRow(CupertinoIcons.person, 'Sur name', widget.surName),
            buildInfoRow(Icons.work_outline, 'Career', widget.carrier),

            buildInfoRow(
              Icons.calendar_today,
              'Joining Date',
              widget.joiningDate,
            ),
            buildInfoRow(Icons.person, 'Role', widget.role),
            buildInfoRow(
                Icons.check_circle_outline, 'Attendance', widget.attendance),
            if (widget.OnDelete != null) ...[
              SizedBox(height: 30),
              DeleteButton(onPressed: widget.OnDelete!),
            ],
            if (widget.OnAssign != null) ...[
              SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: widget.OnAssign,
                  child: Text(
                    'Assign an Project',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),
                  ))
            ]
          ],
        ),
      ),
    );
  }
}
