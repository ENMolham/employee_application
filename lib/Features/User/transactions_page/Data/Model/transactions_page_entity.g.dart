// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_page_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionsPageEntity _$TransactionsPageEntityFromJson(
  Map<String, dynamic> json,
) => TransactionsPageEntity(
  message: json['message'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => Data.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TransactionsPageEntityToJson(
  TransactionsPageEntity instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  transactionID: json['transactionID'] as String,
  transactionName: json['transactionName'] as String,
  nameUserSubmaitTransaction: json['nameUserSubmaitTransaction'] as String,
  nationalId: json['nationalId'] as String,
  dateSubmaitTransaction: json['dateSubmaitTransaction'] as String,
  dateReceiveTransaction: json['dateReceiveTransaction'] as String,
  dateEndTransaction: json['dateEndTransaction'] as String?,
  statusTransaction: json['statusTransaction'] as String,
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'transactionID': instance.transactionID,
  'transactionName': instance.transactionName,
  'nameUserSubmaitTransaction': instance.nameUserSubmaitTransaction,
  'nationalId': instance.nationalId,
  'dateSubmaitTransaction': instance.dateSubmaitTransaction,
  'dateReceiveTransaction': instance.dateReceiveTransaction,
  'dateEndTransaction': instance.dateEndTransaction,
  'statusTransaction': instance.statusTransaction,
};
