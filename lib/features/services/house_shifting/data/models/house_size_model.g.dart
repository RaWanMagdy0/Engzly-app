// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_size_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseSizeModel _$HouseSizeModelFromJson(Map<String, dynamic> json) =>
    HouseSizeModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      icon: json['icon'] as String,
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$HouseSizeModelToJson(HouseSizeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'price': instance.price,
    };
