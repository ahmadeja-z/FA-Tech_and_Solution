import 'package:fasolution/App/Model/Model/UserModel.dart';
import 'package:fasolution/App/Resources/Components/AppBar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Resources/Color.dart';


class DetailProfileInfo extends StatefulWidget {
  DetailProfileInfo({super.key, required this.name, required this.surName, required this.profileImage, required this.carrier, required this.joiningDate, required this.role, required this.attendance, required this.email,});
  final String name;
  final String surName;
  final String email;
  final String profileImage;
  final String carrier;
  final String joiningDate;
  final String role;
  final String attendance;
  @override
  State<DetailProfileInfo> createState() => _DetailProfileInfoState();
}

class _DetailProfileInfoState extends State<DetailProfileInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomizableAppBar(title: 'Pending',
     leadingIcon: Icon(CupertinoIcons.back,color: Colors.white,),
      onLeadingPressed: (){
        Navigator.pop(context);
      },),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage:
              NetworkImage(widget.profileImage),
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

            _buildInfoRow(CupertinoIcons.person, 'Sur name', widget.surName),
            _buildInfoRow(Icons.work_outline, 'Career', widget.carrier),

            _buildInfoRow(Icons.calendar_today, 'Joining Date',
               widget.joiningDate,),
            _buildInfoRow(
                Icons.person, 'Role', widget.role),
            _buildInfoRow(Icons.check_circle_outline, 'Attendance', widget.attendance),
            SizedBox(height: 30),




          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: FColor.primaryColor1),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 16, color: FColor.GreyBrown),
            ),
          ),
        ],
      ),
    );
  }
}