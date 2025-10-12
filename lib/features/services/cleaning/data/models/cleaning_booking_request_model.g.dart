// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cleaning_booking_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CleaningBookingRequestModel _$CleaningBookingRequestModelFromJson(
        Map<String, dynamic> json) =>
    CleaningBookingRequestModel(
      schedule: DateTime.parse(json['schedule'] as String),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      location: json['location'] as String,
      serviceId: (json['serviceId'] as num).toInt(),
      promoCodes: json['promoCodes'] as String,
      paymentMethodId: (json['paymentMethodId'] as num).toInt(),
      houseSizeId: (json['houseSizeId'] as num).toInt(),
    );

Map<String, dynamic> _$CleaningBookingRequestModelToJson(
        CleaningBookingRequestModel instance) =>
    <String, dynamic>{
      'schedule': instance.schedule.toIso8601String(),
      'totalPrice': instance.totalPrice,
      'location': instance.location,
      'serviceId': instance.serviceId,
      'promoCodes': instance.promoCodes,
      'paymentMethodId': instance.paymentMethodId,
      'houseSizeId': instance.houseSizeId,
    };
