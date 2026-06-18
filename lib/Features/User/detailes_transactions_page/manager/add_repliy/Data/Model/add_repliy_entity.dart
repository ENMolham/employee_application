import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_repliy_entity.g.dart';

@JsonSerializable()
class AddRepliyEntity {
  final String message;

  AddRepliyEntity({required this.message});

  factory AddRepliyEntity.fromJson(Map<String, dynamic> json) =>
      _$AddRepliyEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AddRepliyEntityToJson(this);
}
