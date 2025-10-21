
class GetColorsResponseModel {
  final int id;
  final String colorIcon;

  GetColorsResponseModel({
    required this.id,
    required this.colorIcon,
  });

  factory GetColorsResponseModel.fromJson(Map<String, dynamic> json) {
    return GetColorsResponseModel(
      id: json['id'] as int,
      colorIcon: json['colorIcon'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'colorIcon': colorIcon,
    };
  }

 
}
