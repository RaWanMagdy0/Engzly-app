import 'package:json_annotation/json_annotation.dart';

part 'vehicle_booking_request_model.g.dart';

@JsonSerializable()
class VehicleBookingRequestModel {
  final DateTime schedule;
  final double totalPrice;
  final String location;
  final int serviceId;
  final String promoCodes;
  final int paymentMethodId;
  final int vehicleId;

  VehicleBookingRequestModel({
    required this.schedule,
    required this.totalPrice,
    required this.location,
    required this.serviceId,
    required this.promoCodes,
    required this.paymentMethodId,
    required this.vehicleId,
  });

  factory VehicleBookingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VehicleBookingRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleBookingRequestModelToJson(this);
}
