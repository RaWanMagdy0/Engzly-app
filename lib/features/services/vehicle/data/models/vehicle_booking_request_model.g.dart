// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_booking_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleBookingRequestModel _$VehicleBookingRequestModelFromJson(
        Map<String, dynamic> json) =>
    VehicleBookingRequestModel(
      schedule: DateTime.parse(json['schedule'] as String),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      location: json['location'] as String,
      serviceId: (json['serviceId'] as num).toInt(),
      promoCodes: json['promoCodes'] as String,
      paymentMethodId: (json['paymentMethodId'] as num).toInt(),
      vehicleId: (json['vehicleId'] as num).toInt(),
    );

Map<String, dynamic> _$VehicleBookingRequestModelToJson(
        VehicleBookingRequestModel instance) =>
    <String, dynamic>{
      'schedule': instance.schedule.toIso8601String(),
      'totalPrice': instance.totalPrice,
      'location': instance.location,
      'serviceId': instance.serviceId,
      'promoCodes': instance.promoCodes,
      'paymentMethodId': instance.paymentMethodId,
      'vehicleId': instance.vehicleId,
    };
