import 'package:engzly/features/services/house_shifting/data/models/booking/house_booking_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'house_booking_response.g.dart';

@JsonSerializable()
class HouseBookingResponse {
  @JsonKey(defaultValue: 500)
  final int statusCode;
  
  @JsonKey(defaultValue: '')
  final String message;
  
  // ignore: deprecated_member_use
  @JsonKey(nullable: true)
  final HouseBookingData? data;
  
  @JsonKey(defaultValue: false)
  final bool success;

  HouseBookingResponse({
    required this.statusCode,
    required this.message,
    this.data,
    required this.success,
  });

  factory HouseBookingResponse.fromJson(Map<String, dynamic> json) {
    try {
      final response = _$HouseBookingResponseFromJson(json);
      if (response.data != null) {
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$HouseBookingResponseToJson(this);
}