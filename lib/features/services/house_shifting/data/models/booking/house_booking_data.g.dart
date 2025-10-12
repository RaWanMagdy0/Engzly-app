// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_booking_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseBookingData _$HouseBookingDataFromJson(Map<String, dynamic> json) =>
    HouseBookingData(
      stripePaymentIntentId: json['stripePaymentIntentId'] as String?,
      clientSecret: json['clientSecret'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HouseBookingDataToJson(HouseBookingData instance) =>
    <String, dynamic>{
      'stripePaymentIntentId': instance.stripePaymentIntentId,
      'clientSecret': instance.clientSecret,
      'status': instance.status,
    };
