import 'package:dio/dio.dart';
import 'package:foodex_app/app/constraints/api_url.dart';
import 'package:foodex_app/app/constraints/http_services.dart';
import 'package:foodex_app/model/food_category.dart';
import 'package:foodex_app/response/food_category_response.dart';

class FoodCategoryAPI {
  Future<bool> addFoodCategory(FoodCategory foodCategory) async {
    bool isFoodCategoryAdded = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response =
          await dio.post(foodCategoryUrl, data: foodCategory.toJson());
      // response.data
      final FoodCategoryResponse foodCategoryResponseData =
          FoodCategoryResponse.fromJson(response.data);
      if (foodCategoryResponseData.success == true) {
        isFoodCategoryAdded = true;
        return isFoodCategoryAdded;
      }
    } catch (exception) {
      print(exception);
    }
    return isFoodCategoryAdded;
  }

  Future<FoodCategoryResponse?> getAllFoodCategory() async {
    FoodCategoryResponse? foodCategoryResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$foodCategoryUrl/get");
      // response.headers = Headers();
      // response.data
      foodCategoryResponse = FoodCategoryResponse.fromJson(response.data);
      if (foodCategoryResponse.success == true) {
        return foodCategoryResponse;
      } else {
        foodCategoryResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return foodCategoryResponse;
  }

}
