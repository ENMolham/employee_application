import 'package:freezed_annotation/freezed_annotation.dart';

part 'detailes_transactions_page_entity.g.dart';

@JsonSerializable()
class DetailesTransactionsPageEntity {
  final String message;
  final String transactionID;
  final String transactionName;
  final String nameUserSubmaitTransaction;
  final String nationalId;
  final String dateSubmaitTransaction;
  final String? dateEndTransaction;
  final String statusTransaction;
  final List<Attachments>? attachments;
  final List<Timeline> timeline;
  final List<Replies>? replies;
  final List<ModelData>? modelData;
  final String? transactionsCost;
  final String? transactionsPlacedPaied;
  final String? transactionsDatePaied;

  DetailesTransactionsPageEntity({
    required this.message,
    required this.transactionID,
    required this.transactionName,
    required this.nameUserSubmaitTransaction,
    required this.nationalId,
    required this.dateSubmaitTransaction,
    this.dateEndTransaction,
    required this.statusTransaction,
    this.attachments,
    required this.timeline,
    this.replies,
    this.modelData,
    this.transactionsCost,
    this.transactionsPlacedPaied,
    this.transactionsDatePaied,
  });

  factory DetailesTransactionsPageEntity.fromJson(Map<String, dynamic> json) =>
      _$DetailesTransactionsPageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DetailesTransactionsPageEntityToJson(this);
}

@JsonSerializable()
class ModelData {
  final String datakey;
  final String dataValue;

  ModelData({required this.datakey, required this.dataValue});

  factory ModelData.fromJson(Map<String, dynamic> json) =>
      _$ModelDataFromJson(json);

  Map<String, dynamic> toJson() => _$ModelDataToJson(this);
}

@JsonSerializable()
class Attachments {
  final String attachmentType;
  final String attachmentName;
  final String attachmentUploadDate;
  final String attachmentPath;
  final String whoUploaded;

  Attachments({
    required this.attachmentType,
    required this.attachmentName,
    required this.attachmentUploadDate,
    required this.attachmentPath,
    required this.whoUploaded,
  });

  factory Attachments.fromJson(Map<String, dynamic> json) =>
      _$AttachmentsFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentsToJson(this);
}

@JsonSerializable()
class Timeline {
  final String action;
  final String descreption;
  final String date;

  Timeline({
    required this.action,
    required this.descreption,
    required this.date,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) =>
      _$TimelineFromJson(json);

  Map<String, dynamic> toJson() => _$TimelineToJson(this);
}

@JsonSerializable()
class Replies {
  final String type;
  final String name;
  final String date;
  final String? text;
  final List<Attachments>? attachments;

  Replies({
    required this.type,
    required this.name,
    required this.date,
    this.attachments,
    this.text,
  });

  factory Replies.fromJson(Map<String, dynamic> json) =>
      _$RepliesFromJson(json);

  Map<String, dynamic> toJson() => _$RepliesToJson(this);
}
