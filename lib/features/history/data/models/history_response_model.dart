class HistoryResponseModel {
  final int id;
  final String status;
  final String title;
  final String date;
  final String address;
  final double lat;
  final double lng;

  HistoryResponseModel({
    required this.id,
    required this.status,
    required this.title,
    required this.date,
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory HistoryResponseModel.fromJson(Map<String, dynamic> json) {
    return HistoryResponseModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      title: json['title'] ?? '',
      date: json['date'] ?? '',
      address: json['address'] ?? '',
      lat: (json['lat'] ?? 0).toDouble(),
      lng: (json['lng'] ?? 0).toDouble(),
    );
  }
}
