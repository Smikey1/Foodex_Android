import 'package:foodex_app/model/food.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  @JsonKey(name: "_id")
  String? id;
  String? userId;
  Food? foodId;
  int? quantity;

  Cart({this.id, this.userId, this.foodId, this.quantity});

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  Map<String, dynamic> toJson() => _$CartToJson(this);
}
