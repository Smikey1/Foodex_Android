import 'package:json_annotation/json_annotation.dart';

part 'food_category.g.dart';

@JsonSerializable()
class FoodCategory {
  @JsonKey(name: "_id")
  String? id;
  String foodCategoryTitle;
  String foodCategoryImageUrl;
  String foodCategoryCreateAt;

  FoodCategory(this.foodCategoryTitle, this.foodCategoryImageUrl,
      this.foodCategoryCreateAt,
      {this.id});

  factory FoodCategory.fromJson(Map<String, dynamic> json) =>
      _$FoodCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$FoodCategoryToJson(this);
}
