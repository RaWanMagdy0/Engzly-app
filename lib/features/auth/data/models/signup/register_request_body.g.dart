// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestBody _$RegisterRequestBodyFromJson(Map<String, dynamic> json) =>
    RegisterRequestBody(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );

Map<String, dynamic> _$RegisterRequestBodyToJson(
        RegisterRequestBody instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'address': instance.address,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'phoneNumber': instance.phoneNumber,
    };
