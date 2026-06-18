import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomError extends StatelessWidget {
  final double width;
  final double height;
  final double iconsSize;
  final double errorTextSize;
  final String error;
  final void Function() onPressed;
  const CustomError({
    super.key,
    required this.width,
    required this.height,
    required this.iconsSize,
    required this.error,
    required this.onPressed,
    required this.errorTextSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.refresh_rounded,
                size: iconsSize,
                color: Colors.grey,
              ),
            ),
            CustomText(
              text: error,
              color: Colors.grey,
              size: errorTextSize,
              fontWeight: FontWeight.bold,
              paddingTop: context.height(8),
            ),
          ],
        ),
      ),
    );
  }
}
