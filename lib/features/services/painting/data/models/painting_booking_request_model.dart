import 'package:json_annotation/json_annotation.dart';

part 'painting_booking_request_model.g.dart';

@JsonSerializable()
class PaintingBookingRequestModel {
  final DateTime schedule;
  final double totalPrice;
  final String location;
  final int serviceId;
  final String promoCodes;
  final int paymentMethodId;
  final int houseSizeId;
  final int colorId;

  PaintingBookingRequestModel({
    required this.schedule,
    required this.totalPrice,
    required this.location,
    required this.serviceId,
    required this.promoCodes,
    required this.paymentMethodId,
    required this.houseSizeId,
    required this.colorId,
  });

  factory PaintingBookingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PaintingBookingRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaintingBookingRequestModelToJson(this);
}
