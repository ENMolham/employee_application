// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailes_transactions_page_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailesTransactionsPageEntity _$DetailesTransactionsPageEntityFromJson(
  Map<String, dynamic> json,
) => DetailesTransactionsPageEntity(
  message: json['message'] as String,
  transactionID: json['transactionID'] as String,
  transactionName: json['transactionName'] as String,
  nameUserSubmaitTransaction: json['nameUserSubmaitTransaction'] as String,
  nationalId: json['nationalId'] as String,
  dateSubmaitTransaction: json['dateSubmaitTransaction'] as String,
  dateEndTransaction: json['dateEndTransaction'] as String?,
  statusTransaction: json['statusTransaction'] as String,
  attachments: (json['attachments'] as List<dynamic>?)
      ?.map((e) => Attachments.fromJson(e as Map<String, dynamic>))
      .toList(),
  timeline: (json['timeline'] as List<dynamic>)
      .map((e) => Timeline.fromJson(e as Map<String, dynamic>))
      .toList(),
  replies: (json['replies'] as List<dynamic>?)
      ?.map((e) => Replies.fromJson(e as Map<String, dynamic>))
      .toList(),
  modelData: (json['modelData'] as List<dynamic>?)
      ?.map((e) => ModelData.fromJson(e as Map<String, dynamic>))
      .toList(),
  transactionsCost: json['transactionsCost'] as String?,
  transactionsPlacedPaied: json['transactionsPlacedPaied'] as String?,
  transactionsDatePaied: json['transactionsDatePaied'] as String?,
);

Map<String, dynamic> _$DetailesTransactionsPageEntityToJson(
  DetailesTransactionsPageEntity instance,
) => <String, dynamic>{
  'message': instance.message,
  'transactionID': instance.transactionID,
  'transactionName': instance.transactionName,
  'nameUserSubmaitTransaction': instance.nameUserSubmaitTransaction,
  'nationalId': instance.nationalId,
  'dateSubmaitTransaction': instance.dateSubmaitTransaction,
  'dateEndTransaction': instance.dateEndTransaction,
  'statusTransaction': instance.statusTransaction,
  'attachments': instance.attachments,
  'timeline': instance.timeline,
  'replies': instance.replies,
  'modelData': instance.modelData,
  'transactionsCost': instance.transactionsCost,
  'transactionsPlacedPaied': instance.transactionsPlacedPaied,
  'transactionsDatePaied': instance.transactionsDatePaied,
};

ModelData _$ModelDataFromJson(Map<String, dynamic> json) => ModelData(
  datakey: json['datakey'] as String,
  dataValue: json['dataValue'] as String,
);

Map<String, dynamic> _$ModelDataToJson(ModelData instance) => <String, dynamic>{
  'datakey': instance.datakey,
  'dataValue': instance.dataValue,
};

Attachments _$AttachmentsFromJson(Map<String, dynamic> json) => Attachments(
  attachmentType: json['attachmentType'] as String,
  attachmentName: json['attachmentName'] as String,
  attachmentUploadDate: json['attachmentUploadDate'] as String,
  attachmentPath: json['attachmentPath'] as String,
  whoUploaded: json['whoUploaded'] as String,
);

Map<String, dynamic> _$AttachmentsToJson(Attachments instance) =>
    <String, dynamic>{
      'attachmentType': instance.attachmentType,
      'attachmentName': instance.attachmentName,
      'attachmentUploadDate': instance.attachmentUploadDate,
      'attachmentPath': instance.attachmentPath,
      'whoUploaded': instance.whoUploaded,
    };

Timeline _$TimelineFromJson(Map<String, dynamic> json) => Timeline(
  action: json['action'] as String,
  descreption: json['descreption'] as String,
  date: json['date'] as String,
);

Map<String, dynamic> _$TimelineToJson(Timeline instance) => <String, dynamic>{
  'action': instance.action,
  'descreption': instance.descreption,
  'date': instance.date,
};

Replies _$RepliesFromJson(Map<String, dynamic> json) => Replies(
  type: json['type'] as String,
  name: json['name'] as String,
  date: json['date'] as String,
  attachments: (json['attachments'] as List<dynamic>?)
      ?.map((e) => Attachments.fromJson(e as Map<String, dynamic>))
      .toList(),
  text: json['text'] as String?,
);

Map<String, dynamic> _$RepliesToJson(Replies instance) => <String, dynamic>{
  'type': instance.type,
  'name': instance.name,
  'date': instance.date,
  'text': instance.text,
  'attachments': instance.attachments,
};
