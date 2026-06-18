// ignore_for_file: deprecated_member_use

import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/User/notification_page/presentation/notfications_page.dart';
import 'package:employee_application/Features/User/transactions_page/manager/logout/presentation/logout_dialog.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class CustomRowAppbar extends StatelessWidget {
  final String nameUser;
  final String imageUserUrl;
  final String governmentEntityUser;
  const CustomRowAppbar({
    super.key,
    required this.nameUser,
    required this.imageUserUrl,
    required this.governmentEntityUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: context.width(18),
        left: context.width(18),
        top: context.height(24),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: context.width(64),
            height: context.width(64),
            decoration: BoxDecoration(
              color: ColorConstant.greyLight,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUserUrl),
              ),
              borderRadius: BorderRadius.circular(90),
              border: Border.all(
                color: ColorConstant.greyLight,
                width: context.width(1),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: nameUser,
                color: ColorConstant.black,
                size: context.fontSize(18),
                fontWeight: FontWeight.bold,
                paddingRight: context.width(8),
              ),
              CustomText(
                text: "موظف $governmentEntityUser",
                color: ColorConstant.black,
                size: context.fontSize(14),
                fontWeight: FontWeight.bold,
                paddingRight: context.width(8),
                paddingTop: context.height(4),
                paddingBottom: context.height(8),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              showPopover(
                context: context,
                bodyBuilder: (context) => const NotificationsPage(),
                width: context.width(600),
                height: context.height(700),
                direction: PopoverDirection.bottom,
                backgroundColor: ColorConstant.white,
                barrierColor: Colors.black.withOpacity(0.3),
                arrowHeight: context.height(10),
                arrowWidth: context.width(20),
                arrowDxOffset: context.width(-175),
                arrowDyOffset: context.height(-20),
              );
            },
            child: Container(
              width: context.width(48),
              height: context.width(48),
              decoration: BoxDecoration(
                color: ColorConstant.deepGreen,
                borderRadius: BorderRadius.circular(90),
              ),
              child: Center(
                child: Badge(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.notifications,
                    color: ColorConstant.white,
                    size: context.iconSize(30),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(90),
            onTap: () => showLogOutDialog(context: context),
            child: Container(
              width: context.width(48),
              height: context.width(48),
              margin: EdgeInsets.only(right: context.width(18)),
              decoration: BoxDecoration(
                color: ColorConstant.red,
                borderRadius: BorderRadius.circular(90),
              ),
              child: Icon(
                Icons.logout_outlined,
                size: context.iconSize(26),
                color: ColorConstant.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
