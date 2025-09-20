import 'package:json_annotation/json_annotation.dart';

part 'register_request_body.g.dart';

@JsonSerializable()
class RegisterRequestBody {
  final String fullName;
  final String email;
  final String address;
  final String password;
  final String confirmPassword;
  final String phoneNumber;

  RegisterRequestBody({
    required this.fullName,
    required this.email,
    required this.address,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
  });

  factory RegisterRequestBody.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestBodyToJson(this);
}
