import 'package:fasolution/App/Resources/Components/GradientText.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

import '../../../Resources/Color.dart';
import '../../../Resources/Components/AppBar.dart';

// Announcements Page
class AnnouncementsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          GradientText(text: 'Announcement',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: FColor.primaryColor1,
              ),gradient:LinearGradient(colors: FColor.SecondaryGradient) ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildAnnouncementCard(
                    context,
                    'Important Meeting on Friday',
                    'A reminder that the company-wide meeting is scheduled for Friday at 10 AM. Please be on time.',
                    '20 August 2024',
                    Icons.event,
                    Colors.orange,
                  ),
                  _buildAnnouncementCard(
                    context,
                    'New Policy Update',
                    'We have updated our company policy regarding remote work. Please review the changes on our intranet.',
                    '18 August 2024',
                    Icons.policy,
                    Colors.blue,
                  ),
                  _buildAnnouncementCard(
                    context,
                    'Office Renovation',
                    'The office will be undergoing renovations from next week. Expect some changes in the layout and amenities.',
                    '15 August 2024',
                    Icons.build,
                    Colors.green,
                  ),
                  // Add more announcements here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncementCard(
      BuildContext context,
      String title,
      String description,
      String date,
      IconData icon,
      Color iconColor,
      ) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          // Handle card tap
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.1),
                child: Icon(icon, color: iconColor, size: 30),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                GradientText(text: title, gradient: LinearGradient(colors: FColor.PrimaryGradient),style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: FColor.primaryColor1,
                ),),
                    SizedBox(height: 10),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 16,
                        color: FColor.GreyBrown,
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        date,
                        style: TextStyle(
                          fontSize: 14,
                          color: FColor.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}