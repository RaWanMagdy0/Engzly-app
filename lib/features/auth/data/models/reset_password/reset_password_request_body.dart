import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_body.g.dart';

@JsonSerializable()
class ResetPasswordRequestBody {
  final String? email;
  final String? newPassword;
  final String? confirmPassword;

  ResetPasswordRequestBody(
      {this.email, this.confirmPassword, this.newPassword});

  factory ResetPasswordRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestBodyToJson(this);
}
