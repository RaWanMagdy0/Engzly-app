import 'package:json_annotation/json_annotation.dart';
    part 'offer_model.g.dart';
@JsonSerializable()
class OfferModel {
  final int id;
  final String serviceName;
  final String title;
  final String description;
  final double percentage;
  final String icon;
  final String type;
  final bool isActive;
  final String promoCode;
  final double promoDiscount;

  OfferModel({
    required this.id,
    required this.serviceName,
    required this.title,
    required this.description,
    required this.percentage,
    required this.icon,
    required this.type,
    required this.isActive,
    required this.promoCode,
    required this.promoDiscount,
  });


  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}
