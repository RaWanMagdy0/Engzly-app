// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painting_booking_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaintingBookingData _$PaintingBookingDataFromJson(Map<String, dynamic> json) =>
    PaintingBookingData(
      stripePaymentIntentId: json['stripePaymentIntentId'] as String?,
      clientSecret: json['clientSecret'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaintingBookingDataToJson(
        PaintingBookingData instance) =>
    <String, dynamic>{
      'stripePaymentIntentId': instance.stripePaymentIntentId,
      'clientSecret': instance.clientSecret,
      'status': instance.status,
    };
