// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_number_notifications_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNumberNotificationsEntity _$GetNumberNotificationsEntityFromJson(
  Map<String, dynamic> json,
) => GetNumberNotificationsEntity(
  message: json['message'] as String,
  data: NotificationDataEntity.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$GetNumberNotificationsEntityToJson(
  GetNumberNotificationsEntity instance,
) => <String, dynamic>{
  'message': instance.message,
  'data': instance.data.toJson(),
};

NotificationDataEntity _$NotificationDataEntityFromJson(
  Map<String, dynamic> json,
) => NotificationDataEntity(count: (json['count'] as num).toInt());

Map<String, dynamic> _$NotificationDataEntityToJson(
  NotificationDataEntity instance,
) => <String, dynamic>{'count': instance.count};
