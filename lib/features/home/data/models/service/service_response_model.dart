import 'package:json_annotation/json_annotation.dart';

part 'service_response_model.g.dart';

@JsonSerializable()
class ServiceResponseModel {
  final int id;
  final String name;
  final String imageUrl;

  ServiceResponseModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceResponseModelToJson(this);
}
