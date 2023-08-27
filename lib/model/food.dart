import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Food {
  @JsonKey(name: "_id")
  String? id;
  String title;
  String description;
  String price;
  List foodPhoto;
  // List category;
  String createAt;

  Food(this.title, this.description, this.price, this.foodPhoto, this.createAt,
      [this.id]);

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
