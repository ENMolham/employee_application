import 'package:employee_application/Features/User/detailes_transactions_page/Data/Model/detailes_transactions_page_entity.dart';

final DetailesTransactionsPageEntity
fakdetailesTransactionsPageEntity = DetailesTransactionsPageEntity.fromJson({
  "message": "Success",
  "transactionID": "TXN-2024-001",
  "transactionName": "طلب رخصة قيادة",
  "nameUserSubmaitTransaction": "أحمد محمد علي",
  "nationalId": "1234567890",
  "dateSubmaitTransaction": "2024-01-15",
  "dateEndTransaction": null,
  "transactionsCost": null,
  "transactionsPlacedPaied": null,

  // 1 جديدة
  // 2 قيد الدراسة
  // 3 معلقة
  // 4 محولة
  // 5 محولة استثنائياً
  // 6 مرفوضة
  // 7 منتهية
  "statusTransaction": "3",

  "modelData": [
    {"datakey": "رقم الطلب", "dataValue": "TXN-2024-001"},
    {"datakey": "نوع الرخصة", "dataValue": "خاصة"},
    {"datakey": "جهة الإصدار", "dataValue": "إدارة المرور"},
    {"datakey": "مكان الاستلام", "dataValue": "ديوان المديرية"},
    {"datakey": "مدة المعالجة", "dataValue": "3 أيام"},
    {"datakey": "رقم المركبة", "dataValue": "123456"},
    {"datakey": "الفئة", "dataValue": "الفئة الخاصة"},
    {"datakey": "المدينة", "dataValue": "دمشق"},
    {"datakey": "نوع الرخصة", "dataValue": "خاصة"},
    {"datakey": "جهة الإصدار", "dataValue": "إدارة المرور"},
    {"datakey": "مكان الاستلام", "dataValue": "ديوان المديرية"},
    {"datakey": "مدة المعالجة", "dataValue": "3 أيام"},
    {"datakey": "رقم المركبة", "dataValue": "123456"},
    {"datakey": "الفئة", "dataValue": "الفئة الخاصة"},
    {"datakey": "المدينة", "dataValue": "دمشق"},
    {"datakey": "نوع الرخصة", "dataValue": "خاصة"},
    {"datakey": "جهة الإصدار", "dataValue": "إدارة المرور"},
    {"datakey": "مكان الاستلام", "dataValue": "ديوان المديرية"},
    {"datakey": "مدة المعالجة", "dataValue": "3 أيام"},
    {"datakey": "رقم المركبة", "dataValue": "123456"},
    {"datakey": "الفئة", "dataValue": "الفئة الخاصة"},
    {"datakey": "المدينة", "dataValue": "دمشق"},
  ],
  "attachments": [
    {
      "attachmentType": "0", // pdf
      "attachmentName": "دفتر الترشيح",
      "attachmentUploadDate": "2024-01-17",
      "whoUploaded": "محمد ملهم الزقيمي",
      "attachmentPath":
          "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
    },
    {
      "attachmentType": "1", // image
      "attachmentName": "صورة الهوية الشخصية",
      "attachmentUploadDate": "2024-03-15",
      "whoUploaded": "محمد ملهم الزقيمي",
      "attachmentPath":
          "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d",
    },
    {
      "attachmentType": "2", // video
      "attachmentName": "فيديو توضيحي",
      "attachmentUploadDate": "2024-01-15",
      "whoUploaded": "محمد ملهم الزقيمي",
      "attachmentPath":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    },
    {
      "attachmentType": "3", // word
      "attachmentName": "ملف الترشيح",
      "attachmentUploadDate": "2024-01-15",
      "whoUploaded": "محمد ملهم الزقيمي",
      "attachmentPath":
          "https://file-examples.com/storage/fe8c3c3f0a2d3b8c2c0b9/2017/02/file-sample_100kB.docx",
    },
    {
      "attachmentType": "4", // excel
      "attachmentName": "جدول البيانات",
      "attachmentUploadDate": "2024-01-15",
      "whoUploaded": "أنا",
      "attachmentPath":
          "https://file-examples.com/storage/fe8c3c3f0a2d3b8c2c0b9/2017/02/file_example_XLS_10.xls",
    },
  ],

  "timeline": [
    {
      "action": "تقديم المعاملة",
      "descreption":
          "تم تسجيل المعاملة، يرجى سداد الرسوم خلال 24 ساعة لاستكمال المعاملة",
      "date": "2024-01-15 10:30 AM",
    },
    {
      "action": "رفع ايصال الدفع",
      "descreption": "تم رفع ايصال الدفع من قبلك بنجاح",
      "date": "2024-01-16 03:00 PM",
    },
    {
      "action": "جديدة - دائرة الصندوق",
      "descreption": "تم استلام المعاملة للمراجعة والدراسة",
      "date": "2024-01-16 02:15 PM",
    },
    {
      "action": "قيد الدراسة - دائرة الصندوق",
      "descreption": "تم البدء بدراسة المعاملة من قبل دائرة الصندوق",
      "date": "2024-01-16 02:30 PM",
    },
    {
      "action": "معلقة - دائرة الصندوق",
      "descreption":
          "تم تعليق المعاملة من قبل دائرة الصندوق، الرجاء الانتباه إلى الردود",
      "date": "2024-01-17 09:00 AM",
    },
    {
      "action": "محولة استثنائياً - المدير الفرعي",
      "descreption": "تم تحويل المعاملة استثنائياً إلى المدير الفرعي",
      "date": "2024-01-17 11:00 AM",
    },
  ],

  "replies": [
    {
      "type": "0",
      "name": "أنا",
      "date": "2024-01-17 09:10 AM",
      "text": "الرجاء تزويدنا بصورة الهوية الشخصية والوثائق المطلوبة.",
    },
    {
      "type": "1",
      "name": "محمد ملهم الزقيمي",
      "date": "2024-01-17 09:15 AM",
      "text": "تم إرفاق الملفات المطلوبة.",
      "attachments": [
        {
          "whoUploaded": "محمد ملهم الزقيمي",
          "attachmentType": "1",
          "attachmentName": "identity_card.jpg",
          "attachmentUploadDate": "2024-01-17",
          "attachmentPath":
              "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d",
        },
        {
          "whoUploaded": "أنا",
          "attachmentType": "0",
          "attachmentName": "request_document.pdf",
          "attachmentUploadDate": "2024-01-17",
          "attachmentPath":
              "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
        },
      ],
    },
    {
      "type": "0",
      "name": "أنا",
      "date": "2024-01-17 10:15 AM",
      "text": "تم استلام كافة المرفقات بنجاح.",
    },
    {
      "type": "0",
      "name": "أنا",
      "date": "2024-01-17 09:10 AM",
      "text": "الرجاء تزويدنا بصورة الهوية الشخصية والوثائق المطلوبة.",
    },
    {
      "type": "1",
      "name": "محمد ملهم الزقيمي",
      "date": "2024-01-17 09:15 AM",
      "text": "تم إرفاق الملفات المطلوبة.",
      "attachments": [
        {
          "whoUploaded": "محمد ملهم الزقيمي",
          "attachmentType": "1",
          "attachmentName": "identity_card.jpg",
          "attachmentUploadDate": "2024-01-17",
          "attachmentPath":
              "https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d",
        },
        {
          "whoUploaded": "أنا",
          "attachmentType": "0",
          "attachmentName": "request_document.pdf",
          "attachmentUploadDate": "2024-01-17",
          "attachmentPath":
              "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf",
        },
      ],
    },
    {
      "type": "0",
      "name": "أنا",
      "date": "2024-01-17 10:15 AM",
      "text": "تم استلام كافة المرفقات بنجاح.",
    },
  ],
});
