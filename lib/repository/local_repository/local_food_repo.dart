import 'package:foodex_app/data/local_data_source/food_locl_data_source.dart';
import 'package:foodex_app/model/export_model.dart';

abstract class FoodRepositoryOB {
  Future<List<Food>> getFood();
}

class FoodRepositoryImplementation extends FoodRepositoryOB {
  @override
  Future<List<Food>> getFood() {
    return FoodDataSource().getAllFood();
  }
}
