import 'package:flutter/material.dart';

class SideBox extends StatelessWidget {
  final String profileName;
  final String email;
  final String profilePictureUrl;

  const SideBox({
    Key? key,
    required this.profileName,
    required this.email,
    required this.profilePictureUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(profileName),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(profilePictureUrl),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Log Out'),
            onTap: () {
              // Handle logout action here
            },
          ),
        ],
      ),
    );
  }
}
