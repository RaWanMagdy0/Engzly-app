// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painting_booking_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaintingBookingRequestModel _$PaintingBookingRequestModelFromJson(
        Map<String, dynamic> json) =>
    PaintingBookingRequestModel(
      schedule: DateTime.parse(json['schedule'] as String),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      location: json['location'] as String,
      serviceId: (json['serviceId'] as num).toInt(),
      promoCodes: json['promoCodes'] as String,
      paymentMethodId: (json['paymentMethodId'] as num).toInt(),
      houseSizeId: (json['houseSizeId'] as num).toInt(),
      colorId: (json['colorId'] as num).toInt(),
    );

Map<String, dynamic> _$PaintingBookingRequestModelToJson(
        PaintingBookingRequestModel instance) =>
    <String, dynamic>{
      'schedule': instance.schedule.toIso8601String(),
      'totalPrice': instance.totalPrice,
      'location': instance.location,
      'serviceId': instance.serviceId,
      'promoCodes': instance.promoCodes,
      'paymentMethodId': instance.paymentMethodId,
      'houseSizeId': instance.houseSizeId,
      'colorId': instance.colorId,
    };
