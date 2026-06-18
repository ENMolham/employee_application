import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight? fontWeight;
  final double? paddingTop;
  final double? paddingRight;
  final double? paddingLeft;
  final double? paddingBottom;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? spaceLines;
  final TextDecoration? decoration;

  const CustomText({
    super.key,
    required this.text,
    required this.color,
    required this.size,
    this.fontWeight,
    this.paddingTop = 0.0,
    this.paddingRight = 0.0,
    this.paddingLeft = 0.0,
    this.paddingBottom = 0.0,
    this.softWrap,
    this.overflow,
    this.textAlign = TextAlign.start,
    this.spaceLines,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop ?? 0.0,
        right: paddingRight ?? 0.0,
        left: paddingLeft ?? 0.0,
        bottom: paddingBottom ?? 0.0,
      ),
      child: Text(
        text,
        textScaler: TextScaler.noScaling,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          height: spaceLines,
          decoration: decoration,
        ),
        textAlign: textAlign,
        softWrap: softWrap,
        overflow: overflow,
      ),
    );
  }
}
