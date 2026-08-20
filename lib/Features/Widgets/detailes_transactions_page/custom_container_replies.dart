import 'dart:async';

import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Model/detailes_transactions_page_entity.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/cubit/detailes_transactions_page_cubit.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/add_repliy/presentation/add_repliy_dialog.dart';
import 'package:employee_application/Features/Widgets/custom_button.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

import 'package:flutter_bloc/flutter_bloc.dart';

class CustomContainerReplies extends StatefulWidget {
  final DetailesTransactionsPageEntity entity;
  const CustomContainerReplies({super.key, required this.entity});

  @override
  State<CustomContainerReplies> createState() => _CustomContainerRepliesState();
}

class _CustomContainerRepliesState extends State<CustomContainerReplies> {
  void openAttachment(String url) {
    try {
      final newWindow = html.window.open(url, '_blank');
      // ignore: unnecessary_null_comparison, dead_code
      if (newWindow == null) {
        _showErrorMessage(
          "تعذر فتح المرفق، يرجى السماح بالنوافذ المنبثقة للمتصفح",
        );
      }
    } catch (e) {
      _showErrorMessage("تعذر فتح المرفق");
    }
  }

  Future<void> downloadAttachment(String url, String fileName) async {
    html.HttpRequest? request;

    try {
      request = await html.HttpRequest.request(
        url,
        method: 'GET',
        responseType: 'blob',
      );
    } catch (e) {
      if (!mounted) return;
      _showErrorMessage("السيرفر لا يسمح بتنزيل هذا الملف");
      return;
    }
    if (!mounted) return;
    final status = request.status ?? 0;
    if (status < 200 || status >= 300) {
      _showErrorMessage("السيرفر لا يسمح بتنزيل هذا الملف");
      return;
    }
    final blob = request.response as html.Blob?;
    if (blob == null || blob.size == 0) {
      _showErrorMessage("تعذر تنزيل الملف، الملف غير متاح");
      return;
    }
    try {
      final blobUrl = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: blobUrl)
        ..setAttribute('download', fileName)
        ..style.display = 'none';

      html.document.body?.append(anchor);
      anchor.click();
      anchor.remove();
      html.Url.revokeObjectUrl(blobUrl);
    } catch (e) {
      if (!mounted) return;
      _showErrorMessage("تعذر تنزيل الملف");
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomText(
          text: message,
          color: ColorConstant.white,
          size: context.fontSize(13),
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(1214),
      height: context.height(472),
      margin: EdgeInsets.only(
        top: context.height(18),
        right: context.width(18),
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width(18),
              vertical: context.height(18),
            ),
            child: Row(
              children: [
                CustomText(
                  text: "الردود",
                  color: ColorConstant.black,
                  size: context.fontSize(16),
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
                if (widget.entity.statusTransaction.trim() == "3")
                  CustomButton(
                    topPadding: 0,
                    leftPadding: 0,
                    rightPadding: 0,
                    widthButton: context.width(110),
                    heightButton: context.height(44),
                    colorButton: ColorConstant.deepGreen,
                    raduisButton: context.width(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "رد جديد",
                          color: ColorConstant.white,
                          size: context.fontSize(14),
                          paddingLeft: context.width(8),
                        ),
                        Icon(
                          Icons.send,
                          size: context.iconSize(16),
                          color: ColorConstant.white,
                        ),
                      ],
                    ),
                    onTap: () async {
                      final result = await showAddReplyDialog(
                        context: context,
                        transactionId: widget.entity.transactionID,
                      );
                      if (result != null && context.mounted) {
                        context
                            .read<DetailesTransactionsPageCubit>()
                            .emitdetailesTransactionsPage(
                              widget.entity.transactionID,
                            );
                      }
                    },
                  ),
              ],
            ),
          ),
          if (widget.entity.replies == null || widget.entity.replies!.isEmpty)
            Container(
              height: context.height(370),
              margin: EdgeInsets.only(right: context.width(18)),
              child: Center(
                child: CustomText(
                  text: "لا يوجد ردود",
                  color: ColorConstant.grey,
                  size: context.fontSize(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (widget.entity.replies != null &&
              widget.entity.replies!.isNotEmpty)
            Container(
              height: context.height(370),
              margin: EdgeInsets.only(right: context.width(18)),
              child: ListView.builder(
                itemCount: widget.entity.replies!.length,
                padding: EdgeInsets.only(bottom: context.height(18)),
                reverse: true,
                itemBuilder: (context, index) {
                  final item = widget
                      .entity
                      .replies![widget.entity.replies!.length - 1 - index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: context.width(22),
                            backgroundColor: item.type == "0"
                                ? ColorConstant.deepGreen
                                : ColorConstant.khaki,
                            child: CustomText(
                              text: item.name.substring(0, 1),
                              color: ColorConstant.white,
                              size: context.fontSize(14),
                              fontWeight: FontWeight.bold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: item.name,
                                  color: ColorConstant.grey,
                                  size: context.fontSize(12),
                                  fontWeight: FontWeight.bold,
                                  paddingRight: context.width(8),
                                ),
                                if (item.text != null)
                                  CustomText(
                                    text: item.text ?? "",
                                    color: ColorConstant.black,
                                    size: context.fontSize(13),
                                    fontWeight: FontWeight.bold,
                                    paddingRight: context.width(8),
                                    paddingTop: context.height(12),
                                  ),
                                if (item.attachments != null)
                                  ListView.builder(
                                    itemCount: item.attachments!.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      final att = item.attachments![index];
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          right: context.width(8),
                                          top: context.height(12),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                openAttachment(
                                                  att.attachmentPath,
                                                );
                                              },
                                              child: Icon(
                                                Icons.open_in_new,
                                                size: context.iconSize(16),
                                                color: ColorConstant.grey,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                right: context.width(12),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  downloadAttachment(
                                                    att.attachmentPath,
                                                    att.attachmentName,
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.download,
                                                  size: context.iconSize(16),
                                                  color: ColorConstant.grey,
                                                ),
                                              ),
                                            ),
                                            CustomText(
                                              text: att.attachmentName,
                                              color: ColorConstant.black,
                                              size: context.fontSize(12),
                                              fontWeight: FontWeight.bold,
                                              paddingRight: context.width(12),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: item.date,
                            color: ColorConstant.grey,
                            size: context.fontSize(10),
                            fontWeight: FontWeight.bold,
                            paddingLeft: context.width(18),
                          ),
                        ],
                      ),
                      if (index != 0)
                        Padding(
                          padding: EdgeInsets.only(left: context.width(18)),
                          child: Divider(color: ColorConstant.greyLight),
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
