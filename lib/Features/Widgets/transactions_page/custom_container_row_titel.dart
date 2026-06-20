import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomContainerRowTitel extends StatelessWidget {
  final List<String> items;
  final int flex;
  const CustomContainerRowTitel({
    super.key,
    required this.items,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: context.width(18),
        left: context.width(18),
        top: context.height(32),
      ),
      padding: EdgeInsets.symmetric(vertical: context.height(16)),
      decoration: BoxDecoration(
        color: ColorConstant.greyLight,
        borderRadius: BorderRadius.circular(context.width(50)),
      ),
      child: Row(
        children: items.map((entry) {
          return Expanded(
            flex: flex,
            child: CustomText(
              text: entry,
              color: ColorConstant.black,
              size: context.fontSize(14),
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              overflow: TextOverflow.fade,
            ),
          );
        }).toList(),
      ),
    );
  }
}
