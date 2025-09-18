// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OffersResponseModel _$OffersResponseModelFromJson(Map<String, dynamic> json) =>
    OffersResponseModel(
      type: json['type'] as String,
      offers: (json['offers'] as List<dynamic>)
          .map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OffersResponseModelToJson(
        OffersResponseModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'offers': instance.offers,
    };
