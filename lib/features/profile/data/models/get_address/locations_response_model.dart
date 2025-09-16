import 'package:json_annotation/json_annotation.dart';
import 'location_model.dart';

part 'locations_response_model.g.dart';

@JsonSerializable()
class LocationsResponseModel {
  final List<LocationModel> locations;

  LocationsResponseModel({required this.locations});

  factory LocationsResponseModel.fromJson(List<dynamic> json) {
    return LocationsResponseModel(
      locations: json.map((e) => LocationModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
