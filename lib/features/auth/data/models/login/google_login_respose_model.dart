import 'package:json_annotation/json_annotation.dart';
part 'google_login_respose_model.g.dart';

@JsonSerializable()
class GoogleLoginResposeModel {
  final String? token;
  final String? refreshToken;
  final String? email;
  final String? username;
  final String? image;
  final bool isSuccess;
  final String? loginType;
  final String? message;

  GoogleLoginResposeModel({
    this.token,
    this.refreshToken,
    this.email,
    this.username,
    this.image,
    required this.isSuccess,
    this.loginType,
    this.message,
  });

  factory GoogleLoginResposeModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleLoginResposeModelFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleLoginResposeModelToJson(this);
}
