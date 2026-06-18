import 'package:freezed_annotation/freezed_annotation.dart';

part 'transactions_page_entity.g.dart';

@JsonSerializable()
class TransactionsPageEntity {
  final String message;
  final List<Data> data;

  TransactionsPageEntity({required this.message, required this.data});

  factory TransactionsPageEntity.fromJson(Map<String, dynamic> json) =>
      _$TransactionsPageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsPageEntityToJson(this);
}

@JsonSerializable()
class Data {
  final String transactionID;
  final String transactionName;
  final String nameUserSubmaitTransaction;
  final String nationalId;
  final String dateSubmaitTransaction;
  final String dateReceiveTransaction;
  final String? dateEndTransaction;
  final String statusTransaction;

  Data({
    required this.transactionID,
    required this.transactionName,
    required this.nameUserSubmaitTransaction,
    required this.nationalId,
    required this.dateSubmaitTransaction,
    required this.dateReceiveTransaction,
    this.dateEndTransaction,
    required this.statusTransaction,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
