import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text('Delete'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Border radius
        ),
      ),
    );
  }
}
