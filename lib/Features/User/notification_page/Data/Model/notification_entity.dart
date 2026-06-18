import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entity.g.dart';

@JsonSerializable()
class NotificationEntity {
  final String message;
  final List<Data> data;

  NotificationEntity({required this.message, required this.data});

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationEntityToJson(this);
}

@JsonSerializable()
class Data {
  final String title;
  final String subtitle;
  final int type;
  final int status;
  final String date;

  Data({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.status,
    required this.date,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
