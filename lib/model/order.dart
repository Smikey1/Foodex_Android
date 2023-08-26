import 'package:foodex_app/model/food.dart';
import 'package:foodex_app/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: "_id")
  String? id;
  User? userId;
  Food? foodId;
  int? orderedQuantity;
  int? totalPrice;
  String? deliveryStatusMessage;
  String? deliveryDate;

  Order(
      {this.id,
      this.userId,
      this.foodId,
      this.orderedQuantity,
      this.totalPrice,
      this.deliveryStatusMessage,
      this.deliveryDate});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
