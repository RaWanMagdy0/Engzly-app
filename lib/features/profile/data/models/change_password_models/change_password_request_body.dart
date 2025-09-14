import 'package:json_annotation/json_annotation.dart';

part 'change_password_request_body.g.dart';

@JsonSerializable()
class ChangePasswordRequestBody {
  final String? email;
  final String? password;
  final String? newPassword;

  final String? confirmPassword;

  ChangePasswordRequestBody({
    this.password,
    this.newPassword,
    this.email,
    this.confirmPassword,
  });

  factory ChangePasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordRequestBodyToJson(this);
}
