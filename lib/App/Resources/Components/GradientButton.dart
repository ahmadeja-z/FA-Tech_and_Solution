import 'package:flutter/material.dart';

import '../Color.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.ButtonTitle,
  });
  final String ButtonTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 315,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: FColor.primaryColor1, blurRadius: 10, offset: Offset(1, 7))
        ],
        borderRadius: BorderRadius.circular(50),
        gradient: LinearGradient(
            colors: FColor.PrimaryGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ButtonTitle,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
