import 'package:flutter/material.dart';

class DocumentRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;

  const DocumentRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = Colors.black, // Default color if not provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(label),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}