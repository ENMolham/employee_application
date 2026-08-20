// ignore_for_file: deprecated_member_use

import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/User/notification_page/presentation/notfications_page.dart';
import 'package:employee_application/Features/User/transactions_page/manager/get_number_notifications/Data/Model/get_number_notifications_entity.dart';
import 'package:employee_application/Features/User/transactions_page/manager/get_number_notifications/cubit/get_number_notifications_cubit.dart';
import 'package:employee_application/Features/Auth/logout/presentation/logout_dialog.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:employee_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popover/popover.dart';

class CustomRowAppbar extends StatefulWidget {
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
  State<CustomRowAppbar> createState() => _CustomRowAppbarState();
}

class _CustomRowAppbarState extends State<CustomRowAppbar> {
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<GetNumberNotificationsCubit>();
        cubit.emitgetNumberNotifications();
        return cubit;
      },
      child: Container(
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
                  image: NetworkImage(widget.imageUserUrl),
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
                  text: widget.nameUser,
                  color: ColorConstant.black,
                  size: context.fontSize(18),
                  fontWeight: FontWeight.bold,
                  paddingRight: context.width(8),
                ),
                CustomText(
                  text: "موظف ${widget.governmentEntityUser}",
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
            BlocBuilder<
              GetNumberNotificationsCubit,
              GetNumberNotificationsState
            >(
              builder: (context, state) {
                Widget notificationIcon = Icon(
                  Icons.notifications,
                  color: ColorConstant.white,
                  size: context.iconSize(30),
                );
                return GestureDetector(
                  onTap: () {
                    showPopover(
                      context: context,
                      bodyBuilder: (context) => const NotificationsPage(),
                      width: context.width(600),
                      height: context.height(700),
                      direction: PopoverDirection.bottom,
                      backgroundColor: Colors.white,
                      barrierColor: Colors.black.withOpacity(0.3),
                      arrowHeight: context.height(10),
                      arrowWidth: context.width(20),
                      arrowDxOffset: context.width(-175),
                      arrowDyOffset: isLoaded
                          ? context.height(0)
                          : context.height(0),
                    );
                    if (!mounted) return;
                    context
                        .read<GetNumberNotificationsCubit>()
                        .emitgetNumberNotifications();
                  },

                  child: Container(
                    width: context.width(48),
                    height: context.width(48),
                    decoration: BoxDecoration(
                      color: ColorConstant.deepGreen,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: Center(
                      child: state.when(
                        initial: () => notificationIcon,
                        loading: () => notificationIcon,
                        error: (error) => notificationIcon,
                        success:
                            (
                              GetNumberNotificationsEntity
                              getNumberNotificationsEntity,
                            ) {
                              if (getNumberNotificationsEntity.data.count > 0 &&
                                  !isLoaded) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  setState(() {
                                    isLoaded = true;
                                  });
                                });
                              }
                              if (getNumberNotificationsEntity.data.count ==
                                  0) {
                                return notificationIcon;
                              }
                              return Badge(
                                alignment: Alignment.topLeft,
                                label: CustomText(
                                  text:
                                      "${getNumberNotificationsEntity.data.count}",
                                  color: ColorConstant.white,
                                  size: context.fontSize(12),
                                  fontWeight: FontWeight.bold,
                                ),
                                child: notificationIcon,
                              );
                            },
                      ),
                    ),
                  ),
                );
              },
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
      ),
    );
  }
}
