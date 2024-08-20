import 'package:flutter/cupertino.dart';

import '../Color.dart';

Widget buildInfoRow(IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, color: FColor.primaryColor1),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 16, color: FColor.GreyBrown),
          ),
        ),
      ],
    ),
  );
}