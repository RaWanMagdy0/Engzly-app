// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryResponseModel _$HistoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    HistoryResponseModel(
      id: (json['id'] as num).toInt(),
      serviceName: json['serviceName'] as String,
      schedule: json['schedule'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: json['status'] as String,
      locaion: json['locaion'] as String,
    );

Map<String, dynamic> _$HistoryResponseModelToJson(
        HistoryResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceName': instance.serviceName,
      'schedule': instance.schedule,
      'totalPrice': instance.totalPrice,
      'status': instance.status,
      'locaion': instance.locaion,
    };
