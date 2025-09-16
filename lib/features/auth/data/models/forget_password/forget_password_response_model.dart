import 'package:json_annotation/json_annotation.dart';

part 'forget_password_response_model.g.dart';

@JsonSerializable()
class ForegtPasswordResponseModel {
  final String? result;

  ForegtPasswordResponseModel({
    this.result,
  });

  factory ForegtPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ForegtPasswordResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForegtPasswordResponseModelToJson(this);
}
