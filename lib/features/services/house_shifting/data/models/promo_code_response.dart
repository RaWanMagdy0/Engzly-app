import 'package:json_annotation/json_annotation.dart';

part 'promo_code_response.g.dart';



@JsonSerializable()
class PromoCodeResponse {
  final bool success;
  final String message;
  final double discountPercentage;

  PromoCodeResponse({
    required this.success,
    required this.message,
    required this.discountPercentage,
  });

  factory PromoCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$PromoCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PromoCodeResponseToJson(this);
}
