import 'package:json_annotation/json_annotation.dart';

part 'house_size_model.g.dart';

@JsonSerializable()
class HouseSizeModel {
  final int id;
  final String name;
  final String icon;
  final int price;

  HouseSizeModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.price,
  });

  factory HouseSizeModel.fromJson(Map<String, dynamic> json) =>
      _$HouseSizeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HouseSizeModelToJson(this);
}
