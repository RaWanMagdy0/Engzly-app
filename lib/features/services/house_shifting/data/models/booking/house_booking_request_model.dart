import 'package:json_annotation/json_annotation.dart';

part 'house_booking_request_model.g.dart';

@JsonSerializable()
class HouseBookingRequestModel {
  final DateTime schedule;
  final double totalPrice;
  final String location;
  final int serviceId;
  final String promoCodes;
  final int paymentMethodId;
  final int houseSizeId;
  final int vehiclesId;
  final Map<String, int> furnitures;
  final int packedBoxes;

  HouseBookingRequestModel({
    required this.schedule,
    required this.totalPrice,
    required this.location,
    required this.serviceId,
    required this.promoCodes,
    required this.paymentMethodId,
    required this.houseSizeId,
    required this.vehiclesId,
    required this.furnitures,
    required this.packedBoxes,
  });

  factory HouseBookingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$HouseBookingRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$HouseBookingRequestModelToJson(this);
}
