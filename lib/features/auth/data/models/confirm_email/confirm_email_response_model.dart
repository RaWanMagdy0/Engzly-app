import 'package:json_annotation/json_annotation.dart';

part 'confirm_email_response_model.g.dart';

@JsonSerializable()
class ConfirmEmailResponseModel {
  final String? message;

  ConfirmEmailResponseModel({this.message});

  factory ConfirmEmailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmEmailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmEmailResponseModelToJson(this);
}
