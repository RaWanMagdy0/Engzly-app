// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cleaning_booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CleaningBookingResponse _$CleaningBookingResponseFromJson(
        Map<String, dynamic> json) =>
    CleaningBookingResponse(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String? ?? '',
      data: json['data'] == null
          ? null
          : HouseBookingData.fromJson(json['data'] as Map<String, dynamic>),
      success: json['success'] as bool? ?? false,
    );

Map<String, dynamic> _$CleaningBookingResponseToJson(
        CleaningBookingResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
      'success': instance.success,
    };
