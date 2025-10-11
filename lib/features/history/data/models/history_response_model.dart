import 'package:json_annotation/json_annotation.dart';

part 'history_response_model.g.dart';

@JsonSerializable()
class HistoryResponseModel {
  final int id;
  final String serviceName;
  final String schedule;
  final double totalPrice;
  final String status;
  final String locaion;

  HistoryResponseModel({
    required this.id,
    required this.serviceName,
    required this.schedule,
    required this.totalPrice,
    required this.status,
    required this.locaion,
  });

  factory HistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryResponseModelToJson(this);
}
