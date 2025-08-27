import 'package:json_annotation/json_annotation.dart';

part 'verify_email_response_model.g.dart';

@JsonSerializable()
class VerifyEmailResponseModel {
  final String? message;

  VerifyEmailResponseModel({this.message});

  factory VerifyEmailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyEmailResponseModelToJson(this);
}
