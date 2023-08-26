import 'package:foodex_app/model/food.dart';
import 'package:json_annotation/json_annotation.dart';

part 'single_food_response.g.dart';

@JsonSerializable()
class SingleFoodResponse {
  bool? success;
  String? message;
  Food? data;

  SingleFoodResponse({this.success, this.message, this.data});

  factory SingleFoodResponse.fromJson(Map<String, dynamic> json) =>
      _$SingleFoodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SingleFoodResponseToJson(this);
}
