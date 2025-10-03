import 'package:json_annotation/json_annotation.dart';

part 'vehicle_model.g.dart';

@JsonSerializable()
class VehicleModel {
  final int id;
  final String name;
  final String icon;
  final double capacity;
  final double price;

  VehicleModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.capacity,
    required this.price,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => _$VehicleModelFromJson(json);
  Map<String, dynamic> toJson() => _$VehicleModelToJson(this);
}
