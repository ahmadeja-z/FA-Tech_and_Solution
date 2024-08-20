
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Color.dart';

Widget buildGridTile(
    {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 4.0,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      color: Colors.white.withOpacity(.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              size: 48.0,
              color: FColor.primaryColor1), // Use your primary color here
          const SizedBox(height: 16.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    ),
  );
}

