// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_login_respose_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleLoginResposeModel _$GoogleLoginResposeModelFromJson(
        Map<String, dynamic> json) =>
    GoogleLoginResposeModel(
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      image: json['image'] as String?,
      isSuccess: json['isSuccess'] as bool,
      loginType: json['loginType'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GoogleLoginResposeModelToJson(
        GoogleLoginResposeModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'refreshToken': instance.refreshToken,
      'email': instance.email,
      'username': instance.username,
      'image': instance.image,
      'isSuccess': instance.isSuccess,
      'loginType': instance.loginType,
      'message': instance.message,
    };
