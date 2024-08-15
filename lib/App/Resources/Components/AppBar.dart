import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fasolution/App/Resources/Color.dart';

import '../../UI/NavBar/Notification.dart';

class CustomizedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showDrawerButton; // Controls visibility of the drawer button
  final bool showSearchButton; // Controls visibility of the search button

  const CustomizedAppBar({
    Key? key,
    required this.title,
    this.showDrawerButton = true, // Default to true
    this.showSearchButton = true, // Default to true
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: FColor.PrimaryGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showDrawerButton) ...[
            IconButton(
              icon: Icon(Icons.menu, color: FColor.white),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            ),
          ],
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Lato',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: FColor.white,
            ),
          ),
          if (showSearchButton) ...[
            IconButton(
              icon: Icon(CupertinoIcons.bell, color: FColor.white),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationsPage(),
                    ));
              },
            ),
          ],
        ],
      ),
      elevation: 0,
      toolbarHeight: 80, // Height of the AppBar
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
