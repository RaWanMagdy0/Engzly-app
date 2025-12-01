import 'package:json_annotation/json_annotation.dart';

part 'cleaning_booking_request_model.g.dart';

@JsonSerializable()
class CleaningBookingRequestModel {
  final DateTime schedule;
  final double totalPrice;
  final String location;
  final int serviceId;
  final String? promoCodes;
  final int paymentMethodId;
  final int houseSizeId;

  CleaningBookingRequestModel({
    required this.schedule,
    required this.totalPrice,
    required this.location,
    required this.serviceId,
    this.promoCodes,
    required this.paymentMethodId,
    required this.houseSizeId,
  });

  factory CleaningBookingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CleaningBookingRequestModelFromJson(json);

  Map<String, dynamic> toJson() {
    final map = _$CleaningBookingRequestModelToJson(this);
    if (promoCodes == null || promoCodes!.isEmpty) {
      map.remove('promoCodes');
    }
    return map;
  }
}
