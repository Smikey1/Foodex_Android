import 'package:foodex_app/data/remote_data_source/api/order_api.dart';
import 'package:foodex_app/response/food_order_response.dart';

class OrderRepository {
  Future<bool> addProductToOrder() async {
    return await OrderAPI().addFoodToOrder();
  }

  Future<OrderResponse?> getAllOrder(String status) async {
    return await OrderAPI().getAllOrder(status);
  }

  Future<bool?> deleteProductFromOrder(String foodId) async {
    return await OrderAPI().deleteOrder(foodId);
  }

  Future<bool?> cancelOrder(String orderId) async {
    return await OrderAPI().cancelOrder(orderId);
  }
}
