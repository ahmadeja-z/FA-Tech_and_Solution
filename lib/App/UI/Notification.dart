import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fasolution/App/Resources/Color.dart';

import '../Resources/Components/AppBar2.dart';

class NotificationsPage extends StatelessWidget {
  // Sample notifications data
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'New Feature Available',
      'message': 'We have added a new feature to the app. Check it out!',
      'icon': Icons.new_releases,
    },
    {
      'title': 'System Maintenance',
      'message': 'The system will be down for maintenance on August 15th.',
      'icon': Icons.build,
    },
    {
      'title': 'Update Available',
      'message': 'A new version of the app is available. Please update.',
      'icon': Icons.update,
    },
    // Add more notifications here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomizableAppBar(title: 'Notification',leadingIcon: Icon(CupertinoIcons.back),
        onLeadingPressed: (){
          Navigator.pop(context);
        },),
    body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: notifications.map((notification) {
            return NotificationCard(
              title: notification['title']!,
              message: notification['message']!,
              icon: notification['icon']!,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.message,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: FColor.primaryColor1, // Customize icon background color
          child: Icon(
            icon,
            color: FColor.white,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: FColor.primaryColor1, // Customize text color
          ),
        ),
        subtitle: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            color: FColor.primaryColor2, // Customize text color
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () {
            // Handle action button press
            // For example, navigate to a detailed view or perform an action
          },
        ),
        contentPadding: EdgeInsets.all(16),
      ),
    );
  }
}
