// ignore_for_file: deprecated_member_use

import 'package:json_annotation/json_annotation.dart';
part 'vehicle_booking_data.g.dart';

@JsonSerializable()
class VehicleBookingData {
  @JsonKey(nullable: true)
  final String? stripePaymentIntentId;
  
  @JsonKey(nullable: true)
  final String? clientSecret;
  
  @JsonKey(nullable: true)
  final int? status;

  VehicleBookingData({
    this.stripePaymentIntentId,
    this.clientSecret,
    this.status,
  });

  factory VehicleBookingData.fromJson(Map<String, dynamic> json) {
    try {
      final data = _$VehicleBookingDataFromJson(json);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => _$VehicleBookingDataToJson(this);
}