// ignore_for_file: deprecated_member_use

import 'package:json_annotation/json_annotation.dart';
part 'cleaning_booking_data.g.dart';

@JsonSerializable()
class CleaningBookingData {
  @JsonKey(nullable: true)
  final String? stripePaymentIntentId;
  
  @JsonKey(nullable: true)
  final String? clientSecret;
  
  @JsonKey(nullable: true)
  final int? status;

  CleaningBookingData({
    this.stripePaymentIntentId,
    this.clientSecret,
    this.status,
  });

  factory CleaningBookingData.fromJson(Map<String, dynamic> json) {
    try {
      final data = _$CleaningBookingDataFromJson(json);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$CleaningBookingDataToJson(this);
}