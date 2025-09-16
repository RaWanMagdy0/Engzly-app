// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_data_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserDataRequestBody _$UpdateUserDataRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateUserDataRequestBody(
      json['FullName'] as String,
      json['PhoneNumber'] as String,
      json['CuurentAddress'] as String,
    );

Map<String, dynamic> _$UpdateUserDataRequestBodyToJson(
        UpdateUserDataRequestBody instance) =>
    <String, dynamic>{
      'FullName': instance.fullName,
      'PhoneNumber': instance.phoneNumber,
      'CuurentAddress': instance.cuurentAddress,
    };
