import 'location_model.dart';


class LocationsResponseModel {
  final List<LocationModel> locations;

  LocationsResponseModel({required this.locations});

  factory LocationsResponseModel.fromJson(List<dynamic> json) {
    return LocationsResponseModel(
      locations: json.map((e) => LocationModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
