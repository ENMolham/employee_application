// ignore_for_file: deprecated_member_use

import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Core/extension/navigation_service.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/Auth/logout/cubit/logout_cubit.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:employee_application/app_router.dart';
import 'package:employee_application/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<bool?> showLogOutDialog({required BuildContext context}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return BlocProvider<LogOutCubit>(
        create: (_) => getIt<LogOutCubit>(),
        child: const LogOutDialog(),
      );
    },
  );
}

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogOutCubit, LogOutState>(
      listener: (context, state) {
        state.mapOrNull(
          success: (s) {
            context.popPage();
            context.go(AppRoutes.login);
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.mapOrNull(loading: (_) => true) == true;
        final errorMessage = state.mapOrNull(
          error: (s) => NetworkExceptions.getErrorMessage(s.networkExceptions),
        );

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.width(16)),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: context.width(420),
              minWidth: context.width(380),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.width(24),
                vertical: context.height(28),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: context.width(64),
                    height: context.width(64),
                    decoration: BoxDecoration(
                      color: ColorConstant.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.logout_outlined,
                      size: context.iconSize(30),
                      color: ColorConstant.red,
                    ),
                  ),
                  SizedBox(height: context.height(18)),
                  CustomText(
                    text: "تسجيل الخروج",
                    color: ColorConstant.black,
                    size: context.fontSize(18),
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: context.height(10)),
                  CustomText(
                    text: "هل أنت متأكد من رغبتك في تسجيل الخروج؟",
                    color: ColorConstant.grey,
                    size: context.fontSize(14),
                    fontWeight: FontWeight.w500,
                  ),
                  if (errorMessage != null) ...[
                    SizedBox(height: context.height(14)),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width(12),
                        vertical: context.height(8),
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.red.withOpacity(0.07),
                        borderRadius: BorderRadius.circular(context.width(8)),
                        border: Border.all(
                          color: ColorConstant.red.withOpacity(0.3),
                        ),
                      ),
                      child: CustomText(
                        text: errorMessage,
                        color: ColorConstant.red,
                        size: context.fontSize(12),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  SizedBox(height: context.height(26)),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: isLoading ? null : () => context.popPage(),
                          style: TextButton.styleFrom(
                            backgroundColor: ColorConstant.grey.withOpacity(
                              0.15,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: context.height(12),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.width(50),
                              ),
                            ),
                          ),
                          child: CustomText(
                            text: "إلغاء",
                            color: ColorConstant.black,
                            size: context.fontSize(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: context.width(14)),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.red,
                            disabledBackgroundColor: ColorConstant.red
                                .withOpacity(0.6),
                            padding: EdgeInsets.symmetric(
                              vertical: context.height(12),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                context.width(50),
                              ),
                            ),
                          ),
                          onPressed: isLoading
                              ? null
                              : () => context.read<LogOutCubit>().emitlogOut(),
                          child: isLoading
                              ? SizedBox(
                                  width: context.width(18),
                                  height: context.width(18),
                                  child: CircularProgressIndicator(
                                    strokeWidth: context.width(2.2),
                                    color: Colors.white,
                                  ),
                                )
                              : CustomText(
                                  text: "تسجيل خروج",
                                  color: ColorConstant.white,
                                  size: context.fontSize(14),
                                  fontWeight: FontWeight.w600,
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
