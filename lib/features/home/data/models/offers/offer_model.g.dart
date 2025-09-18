// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      icon: json['icon'] as String?,
      type: json['type'] as String?,
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'type': instance.type,
      'id': instance.id,
    };
