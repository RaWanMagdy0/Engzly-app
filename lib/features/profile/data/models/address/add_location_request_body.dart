import 'package:json_annotation/json_annotation.dart';

part 'add_location_request_body.g.dart';

@JsonSerializable()
class AddLocationRequestBody {
  final String? type;
  final String? location;
  AddLocationRequestBody({
    this.location,
    this.type,
    
  });

  factory AddLocationRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddLocationRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddLocationRequestBodyToJson(this);
}
