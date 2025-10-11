import 'package:json_annotation/json_annotation.dart';

part 'booking_request_model.g.dart';

@JsonSerializable()
class BookingRequestModel {
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

  BookingRequestModel({
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

  factory BookingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BookingRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingRequestModelToJson(this);
}
