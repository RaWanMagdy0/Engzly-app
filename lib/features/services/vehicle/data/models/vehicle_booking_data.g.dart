// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_booking_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleBookingData _$VehicleBookingDataFromJson(Map<String, dynamic> json) =>
    VehicleBookingData(
      stripePaymentIntentId: json['stripePaymentIntentId'] as String?,
      clientSecret: json['clientSecret'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$VehicleBookingDataToJson(VehicleBookingData instance) =>
    <String, dynamic>{
      'stripePaymentIntentId': instance.stripePaymentIntentId,
      'clientSecret': instance.clientSecret,
      'status': instance.status,
    };
