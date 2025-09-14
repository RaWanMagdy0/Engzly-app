import 'package:json_annotation/json_annotation.dart';
part 'get_user_data_response_model.g.dart';

@JsonSerializable()
class GetUserDataResponseModel {
  final String? email;

  @JsonKey(name: "cuurentAddress") 
  final String? address;

  final int? ziPCode;
  final String? fullName;
  final String? phoneNumber;

  @JsonKey(name: "imageURL")
  final String? imageUrl;

  final String? state;

  GetUserDataResponseModel({
    this.address,
    this.ziPCode,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.imageUrl,
    this.state,
  });

  factory GetUserDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetUserDataResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserDataResponseModelToJson(this);
}
