import 'package:foodex_app/data/remote_data_source/api/export_remote_data.dart';
import 'package:foodex_app/model/food_category.dart';
import 'package:foodex_app/response/food_category_response.dart';

class FoodCategoryRepository {
  Future<bool> addFoodCategory(FoodCategory foodCategory) async {
    return await FoodCategoryAPI().addFoodCategory(foodCategory);
  }

  Future<FoodCategoryResponse?> getAllFoodCategory() async {
    return await FoodCategoryAPI().getAllFoodCategory();
  }

  //   Future<SingleCategoryResponse?> getSingleCategory(String categoryId) async {
  //   return await FoodCategoryAPI().getSingleCategory(categoryId);
  // }
}
