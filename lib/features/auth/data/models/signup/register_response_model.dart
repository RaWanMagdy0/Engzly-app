import 'package:json_annotation/json_annotation.dart';

part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  final String? email;
  final String? message;
  final bool? isAuthenticated;
  final List<String>? roles;
  final String? token;
  final String? expiration;

  RegisterResponseModel({
    this.email,
    this.message,
    this.isAuthenticated,
    this.roles,
    this.token,
    this.expiration,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}
