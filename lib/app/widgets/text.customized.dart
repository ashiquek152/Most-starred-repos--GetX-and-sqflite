import 'package:flutter/material.dart';

class TextCustomized extends StatelessWidget {
  const TextCustomized({
    Key? key,
    required this.text,
    required this.textSize,
    required this.textColor,
    this.maxlines = 2,
    this.textAlign = TextAlign.center,
    this.fontStyle = FontStyle.normal,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = "Ubuntu",
  }) : super(key: key);

  final String text;
  final double textSize;
  final Color textColor;
  final FontWeight fontWeight;
  final FontStyle fontStyle;
  final String fontFamily;
  final TextAlign textAlign;
  final int maxlines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxlines,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: textColor,
        fontSize: textSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontFamily: fontFamily,
      ),
    );
  }
}
