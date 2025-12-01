// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromoCodeResponse _$PromoCodeResponseFromJson(Map<String, dynamic> json) =>
    PromoCodeResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
    );

Map<String, dynamic> _$PromoCodeResponseToJson(PromoCodeResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'discountPercentage': instance.discountPercentage,
    };
