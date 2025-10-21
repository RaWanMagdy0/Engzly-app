// ignore_for_file: deprecated_member_use

import 'package:json_annotation/json_annotation.dart';
part 'painting_booking_data.g.dart';

@JsonSerializable()
class PaintingBookingData {
  @JsonKey(nullable: true)
  final String? stripePaymentIntentId;
  
  @JsonKey(nullable: true)
  final String? clientSecret;
  
  @JsonKey(nullable: true)
  final int? status;

  PaintingBookingData({
    this.stripePaymentIntentId,
    this.clientSecret,
    this.status,
  });

  factory PaintingBookingData.fromJson(Map<String, dynamic> json) {
    try {
      final data = _$PaintingBookingDataFromJson(json);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$PaintingBookingDataToJson(this);
}