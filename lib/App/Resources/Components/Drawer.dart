import 'package:flutter/material.dart';

class SideBox extends StatelessWidget {
  final String profileName;
  final String email;
  final String profilePictureUrl;
  final VoidCallback onTap;

  const SideBox({
    Key? key,
    required this.profileName,
    required this.email,
    required this.profilePictureUrl, required this.onTap,
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
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap:onTap,
          ),
        ],
      ),
    );
  }
}
