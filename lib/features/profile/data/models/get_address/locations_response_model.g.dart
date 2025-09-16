// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationsResponseModel _$LocationsResponseModelFromJson(
        Map<String, dynamic> json) =>
    LocationsResponseModel(
      locations: (json['locations'] as List<dynamic>)
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationsResponseModelToJson(
        LocationsResponseModel instance) =>
    <String, dynamic>{
      'locations': instance.locations,
    };
