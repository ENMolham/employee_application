import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/User/notification_page/Data/Model/notification_entity.dart';
import 'package:employee_application/Features/User/notification_page/cubit/notification_cubit.dart';
import 'package:employee_application/Features/Widgets/custom_error.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:employee_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotificationCubit>()..fakEmitnotification(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "الإشعارات",
              color: ColorConstant.black,
              size: context.fontSize(22),
              fontWeight: FontWeight.bold,
              paddingRight: context.width(14),
              paddingTop: context.height(24),
            ),
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                return state.when(
                  error: (NetworkExceptions networkExceptions) {
                    return CustomError(
                      width: context.screenWidth,
                      height: context.height(225),
                      iconsSize: context.iconSize(50),
                      error: NetworkExceptions.getErrorMessage(
                        networkExceptions,
                      ),
                      onPressed: () {
                        context.read<NotificationCubit>().emitnotification();
                      },
                      errorTextSize: context.fontSize(12),
                    );
                  },
                  initial: () => SizedBox(),
                  loading: () {
                    return SizedBox(
                      height: context.height(650),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                  success: (NotificationEntity notificationEntity) {
                    if (notificationEntity.data.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notifications_off,
                              size: context.iconSize(50),
                              color: Colors.grey,
                            ),
                            CustomText(
                              text: "لا يوجد إشعارات ",
                              color: Colors.grey,
                              size: context.fontSize(14),
                              fontWeight: FontWeight.bold,
                              paddingTop: context.height(8),
                            ),
                          ],
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.only(bottom: context.height(8)),
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                          top: context.height(16),
                          right: context.width(14),
                          left: context.width(18),
                          bottom: context.height(16),
                        ),
                        itemCount: notificationEntity.data.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = notificationEntity.data[index];
                          return Card(
                            color: item.status == 0
                                ? ColorConstant.whiteLight
                                : Colors.white,
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: context.width(8),
                              ),
                              leading: CircleAvatar(
                                backgroundColor: ColorConstant.deepGreen,
                                radius: context.width(24),
                                child: Icon(
                                  item.type == 1
                                      ? Icons.sync
                                      : item.type == 2
                                      ? Icons.report
                                      : item.type == 3
                                      ? Icons.campaign
                                      : item.type == 4
                                      ? Icons.verified_user
                                      : Icons.notifications,
                                  color: ColorConstant.white,
                                  size: context.iconSize(24),
                                ),
                              ),
                              title: CustomText(
                                text: item.title,
                                color: ColorConstant.deepGreen,
                                size: context.fontSize(14),
                                fontWeight: FontWeight.bold,
                              ),
                              subtitle: CustomText(
                                text: item.subtitle,
                                color: ColorConstant.deepGreen,
                                size: context.fontSize(12),
                              ),
                              trailing: CustomText(
                                text: item.date,
                                color: ColorConstant.deepGreen,
                                size: context.fontSize(12),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
