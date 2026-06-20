// ignore_for_file: deprecated_member_use

import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Core/extension/navigation_service.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/change_status/cubit/change_status_cubit.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:employee_application/Features/Widgets/custom_text_form_field.dart';
import 'package:employee_application/Features/Widgets/transaction_status_enum.dart';
import 'package:employee_application/injection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<TransactionStatus?> showChangeStatusDialog({
  required BuildContext context,
  required String transactionId,
  required TransactionStatus currentStatus,
}) {
  return showDialog<TransactionStatus>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return BlocProvider<ChangeStatusCubit>(
        create: (_) => getIt<ChangeStatusCubit>(),
        child: ChangeStatusDialog(
          transactionId: transactionId,
          currentStatus: currentStatus,
        ),
      );
    },
  );
}

class ChangeStatusDialog extends StatefulWidget {
  final String transactionId;
  final TransactionStatus currentStatus;
  const ChangeStatusDialog({
    super.key,
    required this.transactionId,
    required this.currentStatus,
  });

  @override
  State<ChangeStatusDialog> createState() => _ChangeStatusDialogState();
}

class _ChangeStatusDialogState extends State<ChangeStatusDialog> {
  TransactionStatus? selectedStatus;
  final TextEditingController reasonController = TextEditingController();
  final List<PlatformFile> pickedFiles = [];
  String? errorText;
  bool isPicking = false;

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  AttachmentRequirement get _requirement =>
      selectedStatus?.attachmentRequirement ?? AttachmentRequirement.none;

  Future<void> _pickFiles() async {
    setState(() {
      isPicking = true;
      errorText = null;
    });
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.any,
        allowMultiple: true,
        withData: true,
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          pickedFiles.addAll(result.files);
        });
      }
    } catch (_) {
      setState(() {
        errorText = "حدث خطأ أثناء اختيار الملفات، حاول مرة أخرى";
      });
    } finally {
      setState(() {
        isPicking = false;
      });
    }
  }

  void _removeFile(int index) {
    setState(() {
      pickedFiles.removeAt(index);
    });
  }

  void _onConfirm() {
    if (selectedStatus == null) {
      setState(() {
        errorText = "يرجى اختيار الحالة الجديدة";
      });
      return;
    }

    if (_requirement == AttachmentRequirement.required) {
      final hasText = reasonController.text.trim().isNotEmpty;
      final hasFiles = pickedFiles.isNotEmpty;
      if (!hasText && !hasFiles) {
        setState(() {
          errorText = "يجب إدخال سبب الرفض أو إرفاق ملف واحد على الأقل";
        });
        return;
      }
    }
    setState(() => errorText = null);
    context.read<ChangeStatusCubit>().emitchangeStatus(
      widget.transactionId,
      selectedStatus!.code,
      pickedFiles.isEmpty ? null : pickedFiles,
      reasonController.text.trim().isEmpty
          ? null
          : reasonController.text.trim(),
    );
  }

  String _fileSizeLabel(PlatformFile file) {
    final bytes = file.size;
    if (bytes < 1024) {
      return "$bytes B";
    }
    if (bytes < 1024 * 1024) {
      return "${(bytes / 1024).toStringAsFixed(1)} KB";
    }
    return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
  }

  @override
  Widget build(BuildContext context) {
    final allowedStatuses = widget.currentStatus.allowedNextStatuses;

    return BlocListener<ChangeStatusCubit, ChangeStatusState>(
      listener: (context, state) {
        state.mapOrNull(
          error: (s) {
            setState(() {
              errorText = NetworkExceptions.getErrorMessage(
                s.networkExceptions,
              );
            });
          },
          success: (s) {
            context.popPage();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: ColorConstant.green,
                content: Text(s.changeStatusEntity.message),
              ),
            );
          },
        );
      },
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(context.width(16)),
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: context.width(800),
            minWidth: context.width(700),
          ),
          child: BlocBuilder<ChangeStatusCubit, ChangeStatusState>(
            builder: (context, state) {
              final isLoading = state.mapOrNull(loading: (_) => true) == true;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(context, isLoading),
                    Row(
                      children: [
                        CustomText(
                          text: "الحالة الحالية :",
                          color: ColorConstant.grey,
                          size: context.fontSize(14),
                          paddingRight: context.width(18),
                        ),
                        SizedBox(width: context.width(6)),
                        StatusBadge(status: widget.currentStatus),
                      ],
                    ),
                    Divider(height: context.height(28)),
                    if (allowedStatuses.isEmpty)
                      buildNoActionAvailable()
                    else
                      ...buildStatusForm(allowedStatuses, isLoading),
                    if (errorText != null) ...[ErrorBanner(text: errorText!)],
                    buildActions(allowedStatuses, isLoading),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, bool isLoading) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width(18),
        vertical: context.height(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: "تغيير حالة المعاملة",
            color: ColorConstant.black,
            size: context.fontSize(18),
            fontWeight: FontWeight.bold,
          ),
          if (!isLoading)
            InkWell(
              onTap: () => context.popPage(),
              borderRadius: BorderRadius.circular(context.width(20)),
              child: Icon(
                Icons.close,
                size: context.iconSize(20),
                color: ColorConstant.grey,
              ),
            ),
        ],
      ),
    );
  }

  Widget buildNoActionAvailable() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: context.height(12),
        horizontal: context.width(12),
      ),
      decoration: BoxDecoration(
        color: ColorConstant.red.withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorConstant.red.withOpacity(0.25)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.block,
            size: context.iconSize(20),
            color: ColorConstant.red,
          ),
          Expanded(
            child: CustomText(
              text: "لا يمكن تغيير حالة هذه المعاملة في وضعها الحالي",
              color: ColorConstant.red,
              size: context.fontSize(12),
              fontWeight: FontWeight.w600,
              paddingRight: context.width(8),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildStatusForm(
    List<TransactionStatus> allowedStatuses,
    bool isLoading,
  ) {
    return [
      CustomText(
        text: "اختر الحالة الجديدة",
        color: ColorConstant.black,
        size: context.fontSize(14),
        fontWeight: FontWeight.w600,
        paddingRight: context.width(18),
        paddingBottom: context.height(32),
      ),
      Padding(
        padding: EdgeInsets.only(
          right: context.width(18),
          bottom: context.height(18),
        ),
        child: Wrap(
          spacing: context.width(12),
          runSpacing: context.width(12),
          children: allowedStatuses.map((status) {
            final isSelected = selectedStatus == status;
            return StatusOption(
              status: status,
              isSelected: isSelected,
              enabled: !isLoading,
              onTap: () {
                setState(() {
                  selectedStatus = status;
                  errorText = null;
                  if (status.attachmentRequirement ==
                      AttachmentRequirement.none) {
                    reasonController.clear();
                    pickedFiles.clear();
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
      if (_requirement != AttachmentRequirement.none) ...[
        Row(
          children: [
            CustomText(
              text: _requirement == AttachmentRequirement.required
                  ? "سبب الرفض أو إرفاق ملف"
                  : "ملاحظات أو إرفاق ملف",
              color: ColorConstant.black,
              size: context.fontSize(14),
              fontWeight: FontWeight.bold,
              paddingTop: context.height(18),
              paddingRight: context.width(18),
            ),
            if (_requirement == AttachmentRequirement.required) ...[
              CustomText(
                text: "( مطلوب )",
                color: ColorConstant.red,
                size: context.fontSize(12),
                fontWeight: FontWeight.w600,
                paddingRight: context.width(4),
                paddingTop: context.height(18),
              ),
            ] else ...[
              CustomText(
                text: "( اختياري )",
                color: ColorConstant.grey,
                size: context.fontSize(12),
                fontWeight: FontWeight.w600,
                paddingRight: context.width(4),
                paddingTop: context.height(18),
              ),
            ],
          ],
        ),
        CustomTextFormField(
          widthFiled: double.infinity,
          radius: context.width(8),
          obscureText: false,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: 5,
          readOnly: isLoading,
          hintText: "اكتب السبب أو الملاحظات هنا...",
          fillColor: ColorConstant.white,
          controller: reasonController,
          paddingTop: context.height(18),
          colorBorder: ColorConstant.grey,
          paddingRight: context.width(18),
          paddingLeft: context.width(18),
          onChanged: (_) {
            if (errorText != null) setState(() => errorText = null);
          },
        ),
        const SizedBox(height: 12),
        AttachmentZone(
          isLoading: isLoading,
          isPicking: isPicking,
          onPick: _pickFiles,
        ),
        if (pickedFiles.isNotEmpty) ...[
          const SizedBox(height: 12),
          ...List.generate(pickedFiles.length, (index) {
            final file = pickedFiles[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FileChip(
                fileName: file.name,
                fileSize: _fileSizeLabel(file),
                onRemove: isLoading ? null : () => _removeFile(index),
              ),
            );
          }),
        ],
      ],
    ];
  }

  Widget buildActions(List<TransactionStatus> allowedStatuses, bool isLoading) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.height(24),
        bottom: context.height(32),
        left: context.width(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: isLoading ? null : () => context.popPage(),
            style: TextButton.styleFrom(
              backgroundColor: ColorConstant.grey,
              padding: EdgeInsets.symmetric(
                horizontal: context.width(42),
                vertical: context.height(8),
              ),
            ),
            child: CustomText(
              text: "إلغاء",
              color: ColorConstant.black,
              size: context.fontSize(14),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: context.width(18)),
          if (allowedStatuses.isNotEmpty)
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.deepGreen,
                disabledBackgroundColor: ColorConstant.deepGreen.withOpacity(
                  0.6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(context.width(50)),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: context.width(42),
                  vertical: context.height(8),
                ),
              ),
              onPressed: isLoading ? null : _onConfirm,
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
                      text: "إرسال",
                      color: ColorConstant.white,
                      size: context.fontSize(14),
                      fontWeight: FontWeight.w600,
                    ),
            ),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final TransactionStatus status;
  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width(12),
        vertical: context.height(8),
      ),
      decoration: BoxDecoration(
        color: status.color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text: status.label,
        color: status.color,
        size: context.fontSize(12),
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class StatusOption extends StatefulWidget {
  final TransactionStatus status;
  final bool isSelected;
  final bool enabled;
  final VoidCallback onTap;

  const StatusOption({
    super.key,
    required this.status,
    required this.isSelected,
    required this.enabled,
    required this.onTap,
  });

  @override
  State<StatusOption> createState() => _StatusOptionState();
}

class _StatusOptionState extends State<StatusOption> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.status.color;
    final selected = widget.isSelected;

    return MouseRegion(
      cursor: widget.enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.forbidden,
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: widget.enabled ? widget.onTap : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: EdgeInsets.symmetric(
            horizontal: context.width(24),
            vertical: context.height(8),
          ),
          decoration: BoxDecoration(
            color: selected
                ? color
                : isHovering
                ? color.withOpacity(0.14)
                : color.withOpacity(0.07),
            borderRadius: BorderRadius.circular(context.width(50)),
            border: Border.all(
              color: selected ? color : color.withOpacity(0.4),
              width: selected ? 1.4 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.35),
                      blurRadius: 8,
                      offset: Offset(0, context.height(2)),
                    ),
                  ]
                : null,
          ),
          child: CustomText(
            text: widget.status.label,
            color: selected ? ColorConstant.white : color,
            size: context.fontSize(14),
            fontWeight: FontWeight.w600,
            paddingRight: context.width(4),
          ),
        ),
      ),
    );
  }
}

class AttachmentZone extends StatefulWidget {
  final bool isLoading;
  final bool isPicking;
  final VoidCallback onPick;

  const AttachmentZone({
    super.key,
    required this.isLoading,
    required this.isPicking,
    required this.onPick,
  });

  @override
  State<AttachmentZone> createState() => _AttachmentZoneState();
}

class _AttachmentZoneState extends State<AttachmentZone> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final disabled = widget.isLoading || widget.isPicking;
    return MouseRegion(
      cursor: disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovering = true),
      onExit: (_) => setState(() => isHovering = false),
      child: GestureDetector(
        onTap: disabled ? null : widget.onPick,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          padding: EdgeInsets.symmetric(
            vertical: context.height(16),
            horizontal: context.width(18),
          ),
          margin: EdgeInsets.symmetric(horizontal: context.width(18)),
          decoration: BoxDecoration(
            color: isHovering
                ? ColorConstant.deepGreen.withOpacity(0.06)
                : ColorConstant.grey.withOpacity(0.04),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isHovering
                  ? ColorConstant.deepGreen
                  : ColorConstant.grey.withOpacity(0.4),
              style: BorderStyle.solid,
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isPicking)
                SizedBox(
                  width: context.width(20),
                  height: context.width(20),
                  child: CircularProgressIndicator(
                    strokeWidth: context.width(2),
                  ),
                )
              else
                Icon(
                  Icons.cloud_upload_outlined,
                  size: context.iconSize(24),
                  color: ColorConstant.deepGreen,
                ),
              CustomText(
                text: widget.isPicking
                    ? "جارٍ فتح نافذة الاختيار..."
                    : "اضغط هنا لإرفاق ملف أو أكثر",
                color: ColorConstant.deepGreen,
                size: context.fontSize(14),
                fontWeight: FontWeight.w600,
                paddingRight: context.width(8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FileChip extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final VoidCallback? onRemove;

  const FileChip({
    super.key,
    required this.fileName,
    required this.fileSize,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width(18),
        vertical: context.height(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: context.width(18)),
      decoration: BoxDecoration(
        color: ColorConstant.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorConstant.grey.withOpacity(0.35)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.insert_drive_file_outlined,
            size: context.iconSize(20),
            color: ColorConstant.deepGreen,
          ),
          Expanded(
            child: CustomText(
              text: fileName,
              color: ColorConstant.black,
              size: context.fontSize(11),
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
              paddingRight: context.width(8),
            ),
          ),
          if (fileSize.isNotEmpty) ...[
            const SizedBox(width: 8),
            CustomText(
              text: fileSize,
              color: ColorConstant.grey,
              size: context.fontSize(11),
              paddingRight: context.width(8),
              fontWeight: FontWeight.bold,
              paddingLeft: context.width(8),
            ),
          ],
          if (onRemove != null) ...[
            InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(context.width(20)),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Icon(
                  Icons.close,
                  size: context.iconSize(20),
                  color: ColorConstant.red,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ErrorBanner extends StatelessWidget {
  final String text;
  const ErrorBanner({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: context.width(12),
        vertical: context.height(8),
      ),
      margin: EdgeInsets.only(
        top: context.height(18),
        right: context.width(18),
        left: context.width(18),
      ),
      decoration: BoxDecoration(
        color: ColorConstant.red.withOpacity(0.07),
        borderRadius: BorderRadius.circular(context.width(8)),
        border: Border.all(color: ColorConstant.red.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline,
            size: context.iconSize(20),
            color: ColorConstant.red,
          ),
          Expanded(
            child: CustomText(
              text: text,
              color: ColorConstant.red,
              size: context.width(12),
              fontWeight: FontWeight.w600,
              paddingRight: context.width(8),
            ),
          ),
        ],
      ),
    );
  }
}
