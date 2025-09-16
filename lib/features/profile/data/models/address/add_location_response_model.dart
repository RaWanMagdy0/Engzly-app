import 'package:json_annotation/json_annotation.dart';

part 'add_location_response_model.g.dart';

@JsonSerializable()
class AddLocationResponseModel {
  final String? message;

  AddLocationResponseModel({this.message});

  factory AddLocationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddLocationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddLocationResponseModelToJson(this);
}
