// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'house_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseBookingResponse _$HouseBookingResponseFromJson(
        Map<String, dynamic> json) =>
    HouseBookingResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 500,
      message: json['message'] as String? ?? '',
      data: json['data'] == null
          ? null
          : HouseBookingData.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool? ?? false,
    );

Map<String, dynamic> _$HouseBookingResponseToJson(
        HouseBookingResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
      'success': instance.success,
    };
