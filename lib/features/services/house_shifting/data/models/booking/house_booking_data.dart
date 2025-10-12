// ignore_for_file: deprecated_member_use

import 'package:json_annotation/json_annotation.dart';
part 'house_booking_data.g.dart';

@JsonSerializable()
class HouseBookingData {
  @JsonKey(nullable: true)
  final String? stripePaymentIntentId;
  
  @JsonKey(nullable: true)
  final String? clientSecret;
  
  @JsonKey(nullable: true)
  final int? status;

  HouseBookingData({
    this.stripePaymentIntentId,
    this.clientSecret,
    this.status,
  });

  factory HouseBookingData.fromJson(Map<String, dynamic> json) {
    try {
      final data = _$HouseBookingDataFromJson(json);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$HouseBookingDataToJson(this);
}