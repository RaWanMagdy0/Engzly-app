// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_data_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserDataResponseModel _$GetUserDataResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetUserDataResponseModel(
      address: json['cuurentAddress'] as String?,
      ziPCode: (json['ziPCode'] as num?)?.toInt(),
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      imageUrl: json['imageURL'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$GetUserDataResponseModelToJson(
        GetUserDataResponseModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'cuurentAddress': instance.address,
      'ziPCode': instance.ziPCode,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'imageURL': instance.imageUrl,
      'state': instance.state,
    };
