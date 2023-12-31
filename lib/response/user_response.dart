import 'package:foodex_app/model/export_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  bool? success;
  String? message;
  User? data;

  UserProfileResponse({this.success, this.message, this.data});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
