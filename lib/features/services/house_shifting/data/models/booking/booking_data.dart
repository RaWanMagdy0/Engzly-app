// ignore_for_file: deprecated_member_use

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
      final data = _$BookingDataFromJson(json);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$BookingDataToJson(this);
}