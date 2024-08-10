import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  const GradientText(
      {super.key, required this.text, this.style, required this.gradient});
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
        
      },
      child: Text(text,style: style?.copyWith(color: Colors.white),),
    );
  }
}
