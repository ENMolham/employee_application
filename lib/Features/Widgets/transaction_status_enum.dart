import 'package:employee_application/Core/constant/colors_constant.dart';
import 'package:flutter/material.dart';

enum TransactionStatus {
  newTransaction,
  underReview,
  suspended,
  transferred,
  exceptionallyTransferred,
  rejected,
  finished,
}

extension TransactionStatusX on TransactionStatus {
  static TransactionStatus fromCode(String code) {
    switch (code.trim()) {
      case "1":
        return TransactionStatus.newTransaction;
      case "2":
        return TransactionStatus.underReview;
      case "3":
        return TransactionStatus.suspended;
      case "4":
        return TransactionStatus.transferred;
      case "5":
        return TransactionStatus.exceptionallyTransferred;
      case "6":
        return TransactionStatus.rejected;
      default:
        return TransactionStatus.finished;
    }
  }

  String get code {
    switch (this) {
      case TransactionStatus.newTransaction:
        return "1";
      case TransactionStatus.underReview:
        return "2";
      case TransactionStatus.suspended:
        return "3";
      case TransactionStatus.transferred:
        return "4";
      case TransactionStatus.exceptionallyTransferred:
        return "5";
      case TransactionStatus.rejected:
        return "6";
      case TransactionStatus.finished:
        return "7";
    }
  }

  String get label {
    switch (this) {
      case TransactionStatus.newTransaction:
        return "جديدة";
      case TransactionStatus.underReview:
        return "قيد الدراسة";
      case TransactionStatus.suspended:
        return "معلقة";
      case TransactionStatus.transferred:
        return "محولة";
      case TransactionStatus.exceptionallyTransferred:
        return "محولة استثنائياً";
      case TransactionStatus.rejected:
        return "مرفوضة";
      case TransactionStatus.finished:
        return "منتهية";
    }
  }

  Color get color {
    switch (this) {
      case TransactionStatus.newTransaction:
        return ColorConstant.blue;
      case TransactionStatus.underReview:
        return ColorConstant.yellow;
      case TransactionStatus.suspended:
        return ColorConstant.orange;
      case TransactionStatus.transferred:
        return ColorConstant.green;
      case TransactionStatus.exceptionallyTransferred:
        return ColorConstant.bronze;
      case TransactionStatus.rejected:
        return ColorConstant.red;
      case TransactionStatus.finished:
        return ColorConstant.khaki;
    }
  }

  List<TransactionStatus> get allowedNextStatuses {
    switch (this) {
      case TransactionStatus.newTransaction:
        return [TransactionStatus.underReview];
      case TransactionStatus.underReview:
        return [
          TransactionStatus.rejected,
          TransactionStatus.transferred,
          TransactionStatus.suspended,
          TransactionStatus.exceptionallyTransferred,
        ];
      case TransactionStatus.suspended:
        return [
          TransactionStatus.transferred,
          TransactionStatus.rejected,
          TransactionStatus.exceptionallyTransferred,
        ];
      case TransactionStatus.transferred:
      case TransactionStatus.exceptionallyTransferred:
      case TransactionStatus.rejected:
      case TransactionStatus.finished:
        return [];
    }
  }

  bool get canChangeStatus => allowedNextStatuses.isNotEmpty;
}

enum AttachmentRequirement { none, optional, required }

extension TransactionStatusAttachmentX on TransactionStatus {
  AttachmentRequirement get attachmentRequirement {
    switch (this) {
      case TransactionStatus.rejected:
        return AttachmentRequirement.required;
      case TransactionStatus.transferred:
      case TransactionStatus.exceptionallyTransferred:
        return AttachmentRequirement.optional;
      case TransactionStatus.suspended:
        return AttachmentRequirement.none;
      case TransactionStatus.newTransaction:
      case TransactionStatus.underReview:
      case TransactionStatus.finished:
        return AttachmentRequirement.none;
    }
  }
}
