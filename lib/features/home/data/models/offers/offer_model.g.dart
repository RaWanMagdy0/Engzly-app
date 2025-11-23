// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      id: (json['id'] as num).toInt(),
      serviceName: json['serviceName'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      percentage: (json['percentage'] as num).toDouble(),
      icon: json['icon'] as String,
      type: json['type'] as String,
      isActive: json['isActive'] as bool,
      promoCode: json['promoCode'] as String,
      promoDiscount: (json['promoDiscount'] as num).toDouble(),
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceName': instance.serviceName,
      'title': instance.title,
      'description': instance.description,
      'percentage': instance.percentage,
      'icon': instance.icon,
      'type': instance.type,
      'isActive': instance.isActive,
      'promoCode': instance.promoCode,
      'promoDiscount': instance.promoDiscount,
    };
