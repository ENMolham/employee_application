import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:flutter/widgets.dart';

class CustomRowData extends StatelessWidget {
  final String keyText;
  final String valueText;
  final Color? colorValueText;
  const CustomRowData({
    super.key,
    required this.keyText,
    required this.valueText,
    this.colorValueText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: context.width(12),
        top: context.height(18),
      ),
      child: Row(
        children: [
          CustomText(
            text: keyText,
            color: ColorConstant.grey,
            size: context.fontSize(12),
            fontWeight: FontWeight.bold,
          ),
          CustomText(
            text: valueText,
            color: colorValueText ?? ColorConstant.black,
            size: context.fontSize(12),
            fontWeight: FontWeight.bold,
            paddingRight: context.width(4),
          ),
        ],
      ),
    );
  }
}
