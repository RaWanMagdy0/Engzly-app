// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_location_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddLocationRequestBody _$AddLocationRequestBodyFromJson(
        Map<String, dynamic> json) =>
    AddLocationRequestBody(
      location: json['location'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$AddLocationRequestBodyToJson(
        AddLocationRequestBody instance) =>
    <String, dynamic>{
      'type': instance.type,
      'location': instance.location,
    };
