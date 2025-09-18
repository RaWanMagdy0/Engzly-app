import 'package:json_annotation/json_annotation.dart';
import 'offer_model.dart';

part 'offers_response_model.g.dart';

@JsonSerializable()
class OffersResponseModel {
  final String type;
  final List<OfferModel> offers;

  OffersResponseModel({
    required this.type,
    required this.offers,
  });

  factory OffersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OffersResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OffersResponseModelToJson(this);
}
