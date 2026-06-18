import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RowItem {
  final String? text;
  final double width;
  final int type;
  final Color? colortext;

  RowItem({this.text, required this.width, required this.type, this.colortext});
}

class CustomRowContainerValue extends StatelessWidget {
  final List<RowItem> items;
  final void Function() onTap;

  const CustomRowContainerValue({
    super.key,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(1856),
      padding: EdgeInsets.symmetric(vertical: context.height(16)),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorConstant.greyLight,
            width: context.height(2),
          ),
        ),
      ),
      child: Row(
        children: items.map((item) {
          return item.type == 0
              ? SizedBox(
                  width: context.width(item.width),
                  child: CustomText(
                    text: item.text ?? "",
                    color: item.colortext ?? ColorConstant.black,
                    size: context.fontSize(12),
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                  ),
                )
              : SizedBox(
                  width: context.width(item.width),
                  child: Center(
                    child: InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width(12),
                          vertical: context.height(12),
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstant.greyLight,
                          borderRadius: BorderRadius.circular(
                            context.width(50),
                          ),
                        ),
                        child: CustomText(
                          text: "عرض التفاصيل",
                          color: ColorConstant.black,
                          size: context.fontSize(10),
                          fontWeight: FontWeight.w600,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                );
        }).toList(),
      ),
    );
  }
}
