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
  returnedToPreviousOffice,
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
      case "7":
        return TransactionStatus.finished;
      case "10":
        return TransactionStatus.returnedToPreviousOffice;
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
      case TransactionStatus.returnedToPreviousOffice:
        return "10";
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
      case TransactionStatus.returnedToPreviousOffice:
        return "إعادة إلى المكتب السابق";
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
      case TransactionStatus.returnedToPreviousOffice:
        return const Color(0xFF7E57C2);
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
          TransactionStatus.returnedToPreviousOffice,
        ];
      case TransactionStatus.suspended:
        return [
          TransactionStatus.transferred,
          TransactionStatus.rejected,
          TransactionStatus.exceptionallyTransferred,
          TransactionStatus.returnedToPreviousOffice,
        ];
      case TransactionStatus.transferred:
      case TransactionStatus.exceptionallyTransferred:
      case TransactionStatus.rejected:
      case TransactionStatus.finished:
      case TransactionStatus.returnedToPreviousOffice:
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
      case TransactionStatus.exceptionallyTransferred:
      case TransactionStatus.returnedToPreviousOffice:
        return AttachmentRequirement.required;
      case TransactionStatus.transferred:
        return AttachmentRequirement.optional;
      case TransactionStatus.suspended:
        return AttachmentRequirement.required;
      case TransactionStatus.newTransaction:
      case TransactionStatus.underReview:
      case TransactionStatus.finished:
        return AttachmentRequirement.none;
    }
  }
}
