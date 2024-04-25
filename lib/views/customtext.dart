import 'package:flutter/material.dart';
import '../configs/constants.dart';

class customtitleText extends StatelessWidget {
  final String label;
  final Color labelColor;
  final double fontSize;
  const customtitleText(
      {super.key,
      required this.label,
      this.labelColor = greytextColor,
      this.fontSize = 17});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          color: labelColor,
          fontSize: fontSize,
          fontWeight: FontWeight.bold),
    );
  }
}
