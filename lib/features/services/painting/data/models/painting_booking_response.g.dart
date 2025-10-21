// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'painting_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaintingBookingResponse _$PaintingBookingResponseFromJson(
        Map<String, dynamic> json) =>
    PaintingBookingResponse(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String? ?? '',
      data: json['data'] == null
          ? null
          : HouseBookingData.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool? ?? false,
    );

Map<String, dynamic> _$PaintingBookingResponseToJson(
        PaintingBookingResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
      'success': instance.success,
    };
