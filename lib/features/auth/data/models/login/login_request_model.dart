import 'package:json_annotation/json_annotation.dart';
part 'login_request_model.g.dart';


@JsonSerializable()
class LoginRequestModel {
  @JsonKey(name: "Email")
  final String email;

  @JsonKey(name: "Password")
  final String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
