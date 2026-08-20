import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Model/detailes_transactions_page_entity.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

class CustomContainerAttachments extends StatefulWidget {
  final DetailesTransactionsPageEntity entity;
  const CustomContainerAttachments({super.key, required this.entity});

  @override
  State<CustomContainerAttachments> createState() =>
      _CustomContainerAttachmentsState();
}

class _CustomContainerAttachmentsState
    extends State<CustomContainerAttachments> {
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

  bool isNewestFirst = true;

  @override
  Widget build(BuildContext context) {
    final attachments = [...?widget.entity.attachments];

    attachments.sort((a, b) {
      final dateA = DateTime.parse(a.attachmentUploadDate);
      final dateB = DateTime.parse(b.attachmentUploadDate);

      return isNewestFirst ? dateB.compareTo(dateA) : dateA.compareTo(dateB);
    });
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
          Padding(
            padding: EdgeInsets.only(
              right: context.width(12),
              top: context.height(18),
              left: context.width(12),
            ),
            child: Row(
              children: [
                CustomText(
                  text: "المرفقات",
                  color: ColorConstant.black,
                  size: context.fontSize(16),
                  fontWeight: FontWeight.bold,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    setState(() {
                      isNewestFirst = !isNewestFirst;
                    });
                  },
                  child: Tooltip(
                    message: isNewestFirst ? "الأحدث أولاً" : "الأقدم أولاً",
                    child: CircleAvatar(
                      backgroundColor: ColorConstant.deepGreen,
                      radius: context.width(16),
                      child: Icon(
                        Icons.swap_vert,
                        size: context.iconSize(18),
                        color: ColorConstant.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.entity.attachments != null &&
              widget.entity.attachments!.isNotEmpty)
            Container(
              width: context.width(598),
              height: context.height(422),
              margin: EdgeInsets.symmetric(vertical: context.height(18)),
              child: ListView.builder(
                itemCount: attachments.length,
                itemBuilder: (context, index) {
                  final item = attachments[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: item.whoUploaded,
                            color: ColorConstant.black,
                            size: context.fontSize(12),
                            fontWeight: FontWeight.bold,
                            paddingRight: context.width(18),
                          ),
                          Spacer(),
                          CustomText(
                            text: item.attachmentUploadDate,
                            color: ColorConstant.grey,
                            size: context.fontSize(10),
                            fontWeight: FontWeight.bold,
                            paddingLeft: context.width(18),
                          ),
                        ],
                      ),
                      CustomText(
                        text: item.attachmentName,
                        color: ColorConstant.khaki,
                        size: context.fontSize(10),
                        fontWeight: FontWeight.bold,
                        paddingRight: context.width(18),
                        paddingTop: context.height(4),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: context.width(18),
                          top: context.height(14),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                openAttachment(item.attachmentPath);
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
                                    item.attachmentPath,
                                    item.attachmentName,
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
                              text: item.attachmentName,
                              color: ColorConstant.black,
                              size: context.fontSize(11),
                              fontWeight: FontWeight.bold,
                              paddingRight: context.width(12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: context.width(18),
                          right: context.width(18),
                          top: context.width(4),
                        ),
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
