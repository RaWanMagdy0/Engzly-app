import 'package:engzly/features/services/house_shifting/data/models/booking/booking_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_response.g.dart';

@JsonSerializable()
class BookingResponse {
  @JsonKey(defaultValue: 500)
  final int statusCode;
  
  @JsonKey(defaultValue: '')
  final String message;
  
  // ignore: deprecated_member_use
  @JsonKey(nullable: true)
  final BookingData? data;
  
  @JsonKey(defaultValue: false)
  final bool success;

  BookingResponse({
    required this.statusCode,
    required this.message,
    this.data,
    required this.success,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    try {
      final response = _$BookingResponseFromJson(json);
      if (response.data != null) {
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$BookingResponseToJson(this);
}