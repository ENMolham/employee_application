// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationEntity _$NotificationEntityFromJson(Map<String, dynamic> json) =>
    NotificationEntity(
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationEntityToJson(NotificationEntity instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  title: json['title'] as String,
  subtitle: json['subtitle'] as String,
  type: (json['type'] as num).toInt(),
  status: (json['status'] as num).toInt(),
  date: json['date'] as String,
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'title': instance.title,
  'subtitle': instance.subtitle,
  'type': instance.type,
  'status': instance.status,
  'date': instance.date,
};
