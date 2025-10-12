// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cleaning_booking_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CleaningBookingData _$CleaningBookingDataFromJson(Map<String, dynamic> json) =>
    CleaningBookingData(
      stripePaymentIntentId: json['stripePaymentIntentId'] as String?,
      clientSecret: json['clientSecret'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CleaningBookingDataToJson(
        CleaningBookingData instance) =>
    <String, dynamic>{
      'stripePaymentIntentId': instance.stripePaymentIntentId,
      'clientSecret': instance.clientSecret,
      'status': instance.status,
    };
