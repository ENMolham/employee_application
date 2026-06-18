import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double topPadding;
  final double leftPadding;
  final double rightPadding;
  final double paddingbuttom;
  final double widthButton;
  final double heightButton;
  final double raduisButton;
  final Color colorButton;
  final void Function()? onTap;
  final Widget child;
  const CustomButton({
    super.key,
    required this.topPadding,
    required this.leftPadding,
    required this.rightPadding,
    required this.widthButton,
    required this.heightButton,
    required this.colorButton,
    required this.raduisButton,
    this.onTap,
    required this.child,
    this.paddingbuttom = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding,
        right: rightPadding,
        left: leftPadding,
        bottom: paddingbuttom,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(raduisButton),
        child: Container(
          width: widthButton,
          height: heightButton,
          decoration: BoxDecoration(
            color: colorButton,
            borderRadius: BorderRadius.all(Radius.circular(raduisButton)),
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
