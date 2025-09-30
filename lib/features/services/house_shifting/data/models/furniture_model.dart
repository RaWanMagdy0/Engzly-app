import 'package:json_annotation/json_annotation.dart';

part 'furniture_model.g.dart';

@JsonSerializable()
class FurnitureModel {
  final int id;
  final String name;
  final String icon;
  final int price;

  FurnitureModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.price,
  });

  factory FurnitureModel.fromJson(Map<String, dynamic> json) =>
      _$FurnitureModelFromJson(json);

  Map<String, dynamic> toJson() => _$FurnitureModelToJson(this);
}
