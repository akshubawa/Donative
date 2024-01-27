import 'package:flutter/material.dart';

class CustomInfoText extends StatelessWidget {
  final Color cardColor;
  final String cardText;
  final double fontSize;
  final FontWeight fontWeight;
  final double textElevation;

  CustomInfoText({
    required this.cardColor,
    required this.cardText,
    this.fontSize = 13,
    this.fontWeight = FontWeight.w500,
    this.textElevation = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: cardColor,
      elevation: textElevation,
      shadowColor: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          cardText,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ),
    );
  }
}
