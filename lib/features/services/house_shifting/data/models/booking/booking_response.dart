import 'package:engzly/features/services/house_shifting/data/models/booking/booking_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_response.g.dart';

@JsonSerializable()
class BookingResponse {
  @JsonKey(defaultValue: 500)
  final int statusCode;
  
  @JsonKey(defaultValue: '')
  final String message;
  
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
      print('🔍 Parsing BookingResponse from: $json');
      final response = _$BookingResponseFromJson(json);
      print('✅ BookingResponse parsed successfully');
      print('🔑 Has data: ${response.data != null}');
      if (response.data != null) {
        print('🔑 Client Secret: ${response.data!.clientSecret}');
      }
      return response;
    } catch (e, stackTrace) {
      print('❌ Error in BookingResponse.fromJson: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$BookingResponseToJson(this);
}