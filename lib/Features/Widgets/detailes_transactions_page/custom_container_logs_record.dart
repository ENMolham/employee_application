import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Model/detailes_transactions_page_entity.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomContainerLogsRecord extends StatelessWidget {
  final DetailesTransactionsPageEntity entity;
  const CustomContainerLogsRecord({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(598),
      height: context.height(518),
      margin: EdgeInsets.only(
        top: context.height(18),
        right: context.width(18),
        bottom: context.height(18),
      ),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        border: BoxBorder.fromLTRB(
          right: BorderSide(color: ColorConstant.grey, width: context.width(2)),
          bottom: BorderSide(
            color: ColorConstant.grey,
            width: context.width(2),
          ),
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "السجل الزمني",
            color: ColorConstant.black,
            size: context.fontSize(16),
            fontWeight: FontWeight.bold,
            paddingRight: context.width(12),
            paddingTop: context.height(18),
          ),
          Container(
            width: context.width(598),
            height: context.height(422),
            margin: EdgeInsets.symmetric(vertical: context.height(18)),
            child: ListView.builder(
              itemCount: entity.timeline.length,
              itemBuilder: (context, index) {
                final item = entity.timeline[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width(18),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: context.width(20),
                            backgroundColor: ColorConstant.deepGreen,
                            child: Icon(
                              Icons.check,
                              size: context.iconSize(18),
                              color: ColorConstant.white,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: item.action,
                                  color: ColorConstant.khaki,
                                  size: context.fontSize(12),
                                  fontWeight: FontWeight.bold,
                                  paddingLeft: context.width(18),
                                  paddingRight: context.width(8),
                                ),
                                CustomText(
                                  text: item.descreption,
                                  color: ColorConstant.black,
                                  size: context.fontSize(10),
                                  fontWeight: FontWeight.bold,
                                  paddingLeft: context.width(18),
                                  paddingRight: context.width(8),
                                  paddingTop: context.height(4),
                                  overflow: TextOverflow.fade,
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: item.date,
                            color: ColorConstant.grey,
                            size: context.fontSize(10),
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                    if (index != entity.timeline.length - 1)
                      Container(
                        height: context.height(80),
                        width: context.width(2),
                        // ignore: deprecated_member_use
                        color: ColorConstant.deepGreen.withOpacity(0.4),
                        margin: EdgeInsets.only(right: context.width(36)),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
