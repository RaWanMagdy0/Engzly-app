import 'package:json_annotation/json_annotation.dart';
    part 'offer_model.g.dart';
@JsonSerializable()
class OfferModel {
  final String? icon;
  final String? type;
  final int? id;

  OfferModel({
    this.icon,
    this.type,
    this.id,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}
