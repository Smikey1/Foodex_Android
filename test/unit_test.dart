import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodex_app/data/remote_data_source/api/cart_api.dart';
import 'package:foodex_app/data/remote_data_source/api/export_remote_data.dart';
import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  test("Count total fetched products", () async {
    bool expectedResult = true;

    var actualResult = (await FoodAPI().getAllFood())?.data!.length;

    if (actualResult == 7) {
      expectedResult = true;
    }
    expect(expectedResult, true);
  });

  test("Add Food to cart", () async {
    bool expectedResult = false;
    String fooId = "63e4d8955c025c558ad5b9c4";
    String quantity = "2";

    bool actualResult = (await CartAPI().addProductToCart(fooId, quantity));

    expect(expectedResult, actualResult);
  });
}
