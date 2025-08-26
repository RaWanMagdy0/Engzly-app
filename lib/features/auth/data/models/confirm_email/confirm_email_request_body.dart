import 'package:json_annotation/json_annotation.dart';

part 'confirm_email_request_body.g.dart';

@JsonSerializable()
class ConfirmEmailRequestBody {
  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "otp")
  final String otp;

  ConfirmEmailRequestBody({required this.email, required this.otp});

  factory ConfirmEmailRequestBody.fromJson(Map<String, dynamic> json) =>
      _$ConfirmEmailRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmEmailRequestBodyToJson(this);
}
