import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
  final String message;
  final String token;
  final String nameUser;
  final String imageUserUrl;
  final String governmentEntityUser;

  LoginEntity({
    required this.message,
    required this.token,
    required this.nameUser,
    required this.imageUserUrl,
    required this.governmentEntityUser,
  });

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);
}
