import 'dart:io';
import 'package:dio/dio.dart';
import 'package:foodex_app/app/constraints/api_url.dart';
import 'package:foodex_app/app/constraints/http_services.dart';
import 'package:foodex_app/model/food.dart';
import 'package:foodex_app/response/food_response.dart';
import 'package:foodex_app/response/single_food_response.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class FoodAPI {
  Future<bool> addFood(File? file, Food food) async {
    bool isFoodAdded = false;
    Dio dio = HttpServices().getDioInstance();
    MultipartFile? foodFinalImageFile;
    if (file != null) {
      var filePath = file.path;

      var mimeType = lookupMimeType(filePath);

      var image = await MultipartFile.fromFile(filePath,
          filename: filePath.split("/").last,
          contentType: MediaType("image", mimeType!.split("/").last));
      foodFinalImageFile = image;
    }
    try {
      // dio ko response
      Map<String, dynamic> foodMap = {
        "name": food.title,
        "description": food.description,
        "image": foodFinalImageFile,
        "price": food.price,
      };
      var foodFormData = FormData.fromMap(foodMap);
      Response response = await dio.post(foodUrl,
          data: foodFormData,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final FoodResponse foodResponseData =
          FoodResponse.fromJson(response.data);
      if (foodResponseData.success == true) {
        isFoodAdded = true;
        return isFoodAdded;
      }
    } catch (exception) {
      print(exception);
    }
    return isFoodAdded;
  }

  Future<FoodResponse?> getAllFood() async {
    FoodResponse? foodResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get(foodUrl);
      // response.data
      foodResponse = FoodResponse.fromJson(response.data);
      if (foodResponse.success == true) {
        return foodResponse;
      } else {
        foodResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return foodResponse;
  }

  Future<SingleFoodResponse?> getSingleFood(String foodId) async {
    SingleFoodResponse? foodResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$foodUrl/$foodId");
      // response.data
      foodResponse = SingleFoodResponse.fromJson(response.data);
      if (foodResponse.success == true) {
        return foodResponse;
      } else {
        foodResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return foodResponse;
  }

  Future<FoodResponse?> getAllFoodCategory(String categoryId) async {
    FoodResponse? foodResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$foodUrl/category/$categoryId");
      // response.data
      foodResponse = FoodResponse.fromJson(response.data);
      if (foodResponse.success == true) {
        return foodResponse;
      } else {
        foodResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return foodResponse;
  }
}
