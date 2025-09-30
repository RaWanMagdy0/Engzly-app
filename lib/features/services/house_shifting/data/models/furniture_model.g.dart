// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'furniture_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FurnitureModel _$FurnitureModelFromJson(Map<String, dynamic> json) =>
    FurnitureModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      icon: json['icon'] as String,
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$FurnitureModelToJson(FurnitureModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'price': instance.price,
    };
