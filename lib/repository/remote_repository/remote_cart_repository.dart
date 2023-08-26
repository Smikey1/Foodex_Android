import 'package:foodex_app/data/remote_data_source/api/cart_api.dart';
import 'package:foodex_app/response/food_cart_response.dart';

class CartRepository {
  Future<bool> addProductToCart(String foodId, String quantity) async {
    return await CartAPI().addProductToCart(foodId, quantity);
  }

  Future<CartResponse?> getAllCart() async {
    return await CartAPI().getAllCart();
  }

  Future<bool?> deleteProductFromCart(String foodId) async {
    return await CartAPI().deleteCart(foodId);
  }
}
