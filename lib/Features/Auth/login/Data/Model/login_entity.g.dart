// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEntity _$LoginEntityFromJson(Map<String, dynamic> json) => LoginEntity(
  message: json['message'] as String,
  token: json['token'] as String,
  nameUser: json['nameUser'] as String,
  imageUserUrl: json['imageUserUrl'] as String,
  governmentEntityUser: json['governmentEntityUser'] as String,
);

Map<String, dynamic> _$LoginEntityToJson(LoginEntity instance) =>
    <String, dynamic>{
      'message': instance.message,
      'token': instance.token,
      'nameUser': instance.nameUser,
      'imageUserUrl': instance.imageUserUrl,
      'governmentEntityUser': instance.governmentEntityUser,
    };
