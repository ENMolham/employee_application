import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Color colorText;
  final double sizeText;
  final double? topPadding;
  final double? rightPadding;
  final double? leftPadding;
  final double? bottomPadding;
  final void Function()? onTap;
  const CustomTextButton({
    super.key,
    required this.text,
    required this.colorText,
    required this.sizeText,
    this.topPadding = 0.0,
    this.rightPadding = 0.0,
    this.leftPadding = 0.0,
    this.bottomPadding = 0.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomText(
        text: text,
        color: colorText,
        size: sizeText,
        fontWeight: FontWeight.bold,
        paddingTop: topPadding,
        paddingRight: rightPadding,
        paddingLeft: leftPadding,
        paddingBottom: bottomPadding,
      ),
    );
  }
}
