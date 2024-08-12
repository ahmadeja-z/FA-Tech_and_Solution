import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fasolution/App/Resources/Color.dart';

class CustomizableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Icon? leadingIcon; // Customizable leading icon
  final VoidCallback? onLeadingPressed; // Action for leading icon

  const CustomizableAppBar({
    Key? key,
    required this.title,
    this.leadingIcon, // Allows passing a custom leading icon
    this.onLeadingPressed, // Allows setting an action for the leading icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false, // Prevent default leading icon
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: FColor.PrimaryGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      leading: leadingIcon != null
          ? IconButton(
        icon: leadingIcon!,
        onPressed: onLeadingPressed, color: Colors.white,
      )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: FColor.white,
          fontFamily: 'Lato'
        ),
      ),
      elevation: 0,
      toolbarHeight: 80, // Height of the AppBar
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60); // Match the toolbarHeight
}
