import 'dart:io';
import 'package:foodex_app/data/remote_data_source/api/food_api.dart';
import 'package:foodex_app/model/food.dart';
import 'package:foodex_app/response/food_response.dart';
import 'package:foodex_app/response/single_food_response.dart';

class FoodRepository {
  Future<bool> addFood(File? file, Food food) async {
    return await FoodAPI().addFood(file, food);
  }

  Future<FoodResponse?> getAllFood() async {
    return await FoodAPI().getAllFood();
  }

  Future<SingleFoodResponse?> getSingleFood(String foodId) async {
    return await FoodAPI().getSingleFood(foodId);
  }

  Future<FoodResponse?> getAllFoodCategory(String categoryId) async {
    return await FoodAPI().getAllFoodCategory(categoryId);
  }
}
