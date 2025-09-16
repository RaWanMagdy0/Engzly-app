import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final String? token;
  final String? refreshToken;
  final String? email;
  final String? username;
  final String? image;

  LoginResponseModel({
    this.token,
    this.refreshToken,
    this.email,
    this.username,
    this.image,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
