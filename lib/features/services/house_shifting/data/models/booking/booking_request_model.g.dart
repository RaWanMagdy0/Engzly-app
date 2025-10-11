// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingRequestModel _$BookingRequestModelFromJson(Map<String, dynamic> json) =>
    BookingRequestModel(
      schedule: DateTime.parse(json['schedule'] as String),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      location: json['location'] as String,
      serviceId: (json['serviceId'] as num).toInt(),
      promoCodes: json['promoCodes'] as String,
      paymentMethodId: (json['paymentMethodId'] as num).toInt(),
      houseSizeId: (json['houseSizeId'] as num).toInt(),
      vehiclesId: (json['vehiclesId'] as num).toInt(),
      furnitures: Map<String, int>.from(json['furnitures'] as Map),
      packedBoxes: (json['packedBoxes'] as num).toInt(),
    );

Map<String, dynamic> _$BookingRequestModelToJson(
        BookingRequestModel instance) =>
    <String, dynamic>{
      'schedule': instance.schedule.toIso8601String(),
      'totalPrice': instance.totalPrice,
      'location': instance.location,
      'serviceId': instance.serviceId,
      'promoCodes': instance.promoCodes,
      'paymentMethodId': instance.paymentMethodId,
      'houseSizeId': instance.houseSizeId,
      'vehiclesId': instance.vehiclesId,
      'furnitures': instance.furnitures,
      'packedBoxes': instance.packedBoxes,
    };
