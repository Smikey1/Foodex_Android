import 'package:foodex_app/model/food_category.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_category_response.g.dart';

@JsonSerializable()
class FoodCategoryResponse {
  bool? success;
  String? message;
  List<FoodCategory>? data;

  FoodCategoryResponse({this.success, this.data});

  factory FoodCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$FoodCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FoodCategoryResponseToJson(this);
}
