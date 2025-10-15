// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleBookingResponse _$VehicleBookingResponseFromJson(
        Map<String, dynamic> json) =>
    VehicleBookingResponse(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String? ?? '',
      data: json['data'] == null
          ? null
          : HouseBookingData.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool? ?? false,
    );

Map<String, dynamic> _$VehicleBookingResponseToJson(
        VehicleBookingResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
      'success': instance.success,
    };
