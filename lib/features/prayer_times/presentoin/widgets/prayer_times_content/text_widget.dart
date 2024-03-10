import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    required this.color,
    required this.fontWeight,
    required this.fontSize,
  });
  final String text;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(

        color: color,
        fontWeight: fontWeight,
        fontFamily: "Almarai",
        fontStyle: FontStyle.normal,
        fontSize: fontSize,
      ),
      //textAlign: TextAlign.right,
    );
  }
}
