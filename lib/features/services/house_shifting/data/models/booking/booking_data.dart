import 'package:json_annotation/json_annotation.dart';
part 'booking_data.g.dart';

@JsonSerializable()
class BookingData {
  @JsonKey(nullable: true)
  final String? stripePaymentIntentId;
  
  @JsonKey(nullable: true)
  final String? clientSecret;
  
  @JsonKey(nullable: true)
  final int? status;

  BookingData({
    this.stripePaymentIntentId,
    this.clientSecret,
    this.status,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    try {
      print('🔍 Parsing BookingData from: $json');
      final data = _$BookingDataFromJson(json);
      print('✅ BookingData parsed successfully');
      print('🔑 Client Secret: ${data.clientSecret}');
      return data;
    } catch (e, stackTrace) {
      print('❌ Error in BookingData.fromJson: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$BookingDataToJson(this);
}