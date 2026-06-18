import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final double radius;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool readOnly;
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final TextAlign textAlign;
  final void Function(String)? onChanged;
  final int? maxLength;
  final double? fontSizeInput;
  final FontWeight? fontWeightInput;
  final Color? colorTextInput;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Color fillColor;
  final Color? colorBorder;
  final double paddingTop;
  final double paddingRight;
  final double paddingLeft;
  final double widthFiled;
  final int? minLines;
  final int? maxLines;
  final bool? isDense;

  const CustomTextFormField({
    super.key,
    required this.widthFiled,
    required this.radius,
    required this.obscureText,
    required this.keyboardType,
    required this.readOnly,
    required this.hintText,
    required this.fillColor,
    this.textAlign = TextAlign.start,
    this.onChanged,
    this.maxLength,
    this.fontSizeInput,
    this.fontWeightInput,
    this.colorTextInput,
    this.paddingRight = 0.0,
    this.paddingLeft = 0.0,
    this.paddingTop = 0.0,
    this.prefix,
    this.suffix,
    this.controller,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.colorBorder,
    this.isDense,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        right: paddingRight,
        left: paddingLeft,
      ),
      child: SizedBox(
        width: widthFiled,
        child: TextFormField(
          controller: controller,
          readOnly: readOnly,
          maxLength: maxLength,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          textAlign: textAlign,
          textAlignVertical: TextAlignVertical.center,
          onChanged: onChanged,
          style: TextStyle(
            fontWeight: fontWeightInput,
            fontSize: fontSizeInput,
            color: colorTextInput,
          ),
          decoration: InputDecoration(
            fillColor: fillColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.width(8),
              vertical: context.height(0),
            ),
            filled: true,
            isDense: isDense ?? true,
            hint: CustomText(
              text: hintText,
              color: ColorConstant.deepGreen,
              size: context.fontSize(16),
              fontWeight: FontWeight.w500,
            ),
            suffixIcon: suffix,
            prefixIcon: prefix,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.width(radius)),
              borderSide: BorderSide(
                color: colorBorder ?? ColorConstant.deepGreen,
                width: context.width(2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.width(radius)),
              borderSide: BorderSide(
                color: ColorConstant.deepGreen,
                width: context.width(1),
              ),
            ),
            errorStyle: TextStyle(
              fontSize: context.fontSize(10),
              fontWeight: FontWeight.bold,
            ),
            helperStyle: TextStyle(
              fontSize: context.fontSize(10),
              fontWeight: FontWeight.bold,
            ),
            errorMaxLines: 1,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.width(radius)),
              borderSide: BorderSide(
                color: ColorConstant.red,
                width: context.width(1.5),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(context.width(radius)),
              borderSide: BorderSide(
                color: ColorConstant.red,
                width: context.width(1.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
