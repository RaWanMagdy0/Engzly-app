// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:json_annotation/json_annotation.dart';

part 'update_user_data_request_body.g.dart';

@JsonSerializable()
class UpdateUserDataRequestBody {
  @JsonKey(ignore: true)
  final File? image;

  @JsonKey(name: "FullName")
  final String fullName;

  @JsonKey(name: "PhoneNumber")
  final String phoneNumber;

  @JsonKey(name: "CuurentAddress")
  final String cuurentAddress;

  UpdateUserDataRequestBody(
    this.fullName,
    this.phoneNumber,
    this.cuurentAddress, {
    this.image,
  });

  factory UpdateUserDataRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDataRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$UpdateUserDataRequestBodyToJson(this);
}
