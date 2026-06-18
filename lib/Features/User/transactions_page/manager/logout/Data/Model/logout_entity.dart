import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_entity.g.dart';

@JsonSerializable()
class LogOutEntity {
  final String message;

  LogOutEntity({required this.message});

  factory LogOutEntity.fromJson(Map<String, dynamic> json) =>
      _$LogOutEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LogOutEntityToJson(this);
}
