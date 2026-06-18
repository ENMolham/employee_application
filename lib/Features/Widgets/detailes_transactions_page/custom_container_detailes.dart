import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:employee_application/Core/extension/screen_size_extension.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Model/detailes_transactions_page_entity.dart';
import 'package:employee_application/Features/Widgets/custom_text.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/change_status/presentation/change_status_dialog.dart';
import 'package:employee_application/Features/Widgets/detailes_transactions_page/custom_row_data.dart';
import 'package:employee_application/Features/Widgets/transaction_status_enum.dart';
import 'package:flutter/material.dart';

class CustomContainerDetailes extends StatefulWidget {
  final DetailesTransactionsPageEntity entity;
  const CustomContainerDetailes({super.key, required this.entity});

  @override
  State<CustomContainerDetailes> createState() =>
      _CustomContainerDetailesState();
}

class _CustomContainerDetailesState extends State<CustomContainerDetailes> {
  late TransactionStatus currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus = TransactionStatusX.fromCode(
      widget.entity.statusTransaction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(624),
      height: context.height(1100),
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
              left: context.width(12),
              top: context.height(18),
              bottom: context.height(6),
            ),
            child: Row(
              children: [
                CustomText(
                  text: "تفاصيل المعاملة",
                  color: ColorConstant.black,
                  size: context.fontSize(16),
                  fontWeight: FontWeight.bold,
                ),
                Spacer(),
                if (currentStatus.canChangeStatus)
                  InkWell(
                    onTap: () async {
                      await showChangeStatusDialog(
                        context: context,
                        currentStatus: currentStatus,
                        transactionId: widget.entity.transactionID,
                      );
                    },
                    borderRadius: BorderRadius.circular(50),
                    child: Padding(
                      padding: EdgeInsets.all(context.width(4)),
                      child: Icon(
                        Icons.more_vert,
                        size: context.iconSize(24),
                        color: ColorConstant.grey,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: context.width(624),
            height: context.height(930),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomRowData(
                    keyText: "رقم المعاملة :",
                    valueText: widget.entity.transactionID,
                  ),
                  CustomRowData(
                    keyText: "اسم المعاملة :",
                    valueText: widget.entity.transactionName,
                  ),
                  CustomRowData(
                    keyText: "اسم مقدم المعاملة :",
                    valueText: widget.entity.nameUserSubmaitTransaction,
                  ),
                  CustomRowData(
                    keyText: "الرقم الوطني :",
                    valueText: widget.entity.nationalId,
                  ),
                  CustomRowData(
                    keyText: "تاريخ تقديم المعاملة :",
                    valueText: widget.entity.dateSubmaitTransaction,
                  ),
                  if (widget.entity.dateEndTransaction != null)
                    CustomRowData(
                      keyText: "تاريخ انتهاء المعاملة :",
                      valueText: widget.entity.dateEndTransaction ?? "---",
                    ),
                  if (widget.entity.transactionsCost != null)
                    CustomRowData(
                      keyText: "رسوم المعاملة :",
                      valueText: widget.entity.transactionsCost ?? "---",
                    ),
                  if (widget.entity.transactionsPlacedPaied != null)
                    CustomRowData(
                      keyText: "مكان دفع الإيصال :",
                      valueText: widget.entity.transactionsPlacedPaied ?? "---",
                    ),
                  CustomRowData(
                    keyText: "حالة المعاملة :",
                    valueText: currentStatus.label,
                    colorValueText: currentStatus.color,
                  ),
                  if (widget.entity.modelData != null)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.entity.modelData!.length,
                      padding: EdgeInsets.only(bottom: context.height(18)),
                      itemBuilder: (context, index) {
                        return CustomRowData(
                          keyText:
                              "${widget.entity.modelData![index].datakey} :",
                          valueText: widget.entity.modelData![index].dataValue,
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
