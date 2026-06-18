import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_status_entity.g.dart';

@JsonSerializable()
class ChangeStatusEntity {
  final String message;

  ChangeStatusEntity({required this.message});

  factory ChangeStatusEntity.fromJson(Map<String, dynamic> json) =>
      _$ChangeStatusEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeStatusEntityToJson(this);
}
