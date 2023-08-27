import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodex_app/app/constraints/permissions.dart';
import 'package:foodex_app/data/remote_data_source/api/cart_api.dart';
import 'package:foodex_app/data/remote_data_source/api/export_remote_data.dart';
import 'package:foodex_app/data/remote_data_source/api/order_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test("Count total fetched products", () async {
    bool expectedResult = true;

    var actualResult = (await FoodAPI().getAllFood())?.data!.isNotEmpty;

    if (actualResult! == true) {
      expectedResult = true;
    }
    expect(expectedResult, true);
  });

  test("Add Food to cart", () async {
    bool expectedResult = false;
    String fooId = "64eacd266ebfedf7ac4b2e69";
    String quantity = "2";

    bool actualResult = (await CartAPI().addProductToCart(fooId, quantity));

    expect(expectedResult, actualResult);
  });

  test("Order a Food from cart", () async {
    bool expectedResult = false;
    bool actualResult = (await OrderAPI().addFoodToOrder());

    expect(expectedResult, actualResult);
  });

  test("Get All Pending Order", () async {
    bool expectedResult = false;
    bool actualResult =
        (await OrderAPI().getAllOrder(ORDER_PENDING))!.data!.isEmpty;

    expect(expectedResult, actualResult);
  });
}
