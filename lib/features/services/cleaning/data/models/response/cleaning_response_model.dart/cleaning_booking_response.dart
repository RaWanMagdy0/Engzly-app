import 'package:engzly/features/services/house_shifting/data/models/booking/house_booking_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cleaning_booking_response.g.dart';

@JsonSerializable()
class CleaningBookingResponse {
  final int statusCode;
  
  @JsonKey(defaultValue: '')
  final String message;
  
  final HouseBookingData? data;
  
  @JsonKey(defaultValue: false)
  final bool success;

  CleaningBookingResponse({
    required this.statusCode,
    required this.message,
    this.data,
    required this.success,
  });

  factory CleaningBookingResponse.fromJson(Map<String, dynamic> json) {
    try {
      final response = _$CleaningBookingResponseFromJson(json);
      if (response.data != null) {
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$CleaningBookingResponseToJson(this);
}