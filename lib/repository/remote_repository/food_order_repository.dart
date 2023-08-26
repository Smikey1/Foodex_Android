import 'package:foodex_app/data/remote_data_source/api/order_api.dart';
import 'package:foodex_app/response/food_order_response.dart';

class OrderRepository {
  Future<bool> addProductToOrder(String foodId, String quantity) async {
    return await OrderAPI().addFoodToOrder(foodId, quantity);
  }

  Future<OrderResponse?> getAllOrder(String status) async {
    return await OrderAPI().getAllOrder(status);
  }

  Future<bool?> deleteProductFromOrder(String foodId) async {
    return await OrderAPI().deleteOrder(foodId);
  }
}
