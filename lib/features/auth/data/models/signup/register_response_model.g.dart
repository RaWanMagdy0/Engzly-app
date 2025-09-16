// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
        Map<String, dynamic> json) =>
    RegisterResponseModel(
      email: json['email'] as String?,
      message: json['message'] as String?,
      isAuthenticated: json['isAuthenticated'] as bool?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      token: json['token'] as String?,
      expiration: json['expiration'] as String?,
    );

Map<String, dynamic> _$RegisterResponseModelToJson(
        RegisterResponseModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'message': instance.message,
      'isAuthenticated': instance.isAuthenticated,
      'roles': instance.roles,
      'token': instance.token,
      'expiration': instance.expiration,
    };
