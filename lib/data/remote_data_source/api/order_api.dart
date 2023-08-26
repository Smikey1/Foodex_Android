import 'dart:io';

import 'package:dio/dio.dart';
import 'package:foodex_app/app/constraints/api_url.dart';
import 'package:foodex_app/app/constraints/http_services.dart';
import 'package:foodex_app/response/food_order_response.dart';

class OrderAPI {
  Future<bool> addFoodToOrder(String foodId, String quantity) async {
    bool isFoodAddedToOrder = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.post("$orderUrl/insert/$foodId/$quantity",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final OrderResponse orderResponseData =
          OrderResponse.fromJson(response.data);
      if (orderResponseData.success == true) {
        isFoodAddedToOrder = true;
        return isFoodAddedToOrder;
      }
    } catch (exception) {
      print(exception);
    }
    return isFoodAddedToOrder;
  }

  Future<OrderResponse?> getAllOrder(String status) async {
    OrderResponse? orderResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$orderUrl/get/$status",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      // response.data
      orderResponse = OrderResponse.fromJson(response.data);
      if (orderResponse.success == true) {
        return orderResponse;
      } else {
        orderResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return orderResponse;
  }

  Future<bool> deleteOrder(String foodId) async {
    bool isOrderDelete = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.delete("$orderUrl/delete/$foodId",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final OrderResponse orderResponseData =
          OrderResponse.fromJson(response.data);
      if (orderResponseData.success == true) {
        isOrderDelete = true;
        return isOrderDelete;
      }
    } catch (exception) {
      print(exception);
    }
    return isOrderDelete;
  }
}
