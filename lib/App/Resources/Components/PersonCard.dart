import 'dart:ui';

import 'package:fasolution/App/Resources/Components/GradientText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Color.dart';

class PersonCard extends StatelessWidget {
  final String name;
  final String profilePictureUrl;
  final String joiningDate;
  final String career;
  final String email; // New field for email
  final String role;  // New field for role

  const PersonCard({
    Key? key,
    required this.name,
    required this.profilePictureUrl,
    required this.joiningDate,
    required this.career,
    required this.email,  // Initialize email
    required this.role,   // Initialize role
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(profilePictureUrl),
                radius: 40,
                backgroundColor: FColor.white,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GradientText(text: name , gradient: LinearGradient(colors: FColor.PrimaryGradient),style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: FColor.primaryColor1,
                  ),),




                  Row(
                    children: <Widget>[
                      Icon(Icons.email, color: FColor.GreyBrown, size: 16),
                      SizedBox(width: 8),
                      Text(
                        email,
                        style: TextStyle(
                          fontSize: 12,
                          color: FColor.GreyBrown,
                          fontFamily: 'Poppins'
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Icon(Icons.person, color: FColor.GreyBrown, size: 16),
                      SizedBox(width: 8),
                      Text(
                        role,
                        style: TextStyle(
                          fontSize: 16,
                          color: FColor.GreyBrown,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
