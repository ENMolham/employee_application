import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_number_notifications_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class GetNumberNotificationsEntity {
  final String message;
  final NotificationDataEntity data;

  GetNumberNotificationsEntity({required this.message, required this.data});

  factory GetNumberNotificationsEntity.fromJson(Map<String, dynamic> json) =>
      _$GetNumberNotificationsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetNumberNotificationsEntityToJson(this);
}

@JsonSerializable()
class NotificationDataEntity {
  final int count;

  NotificationDataEntity({required this.count});

  factory NotificationDataEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataEntityToJson(this);
}
