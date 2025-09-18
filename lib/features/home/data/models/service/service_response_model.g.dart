// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceResponseModel _$ServiceResponseModelFromJson(
        Map<String, dynamic> json) =>
    ServiceResponseModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$ServiceResponseModelToJson(
        ServiceResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
    };
