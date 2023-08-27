import 'package:foodex_app/helper/objectbox.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/state/objectbox_state.dart';

class FoodDataSource {
  ObjectBoxInstance objectBoxInstance = ObjectBoxState.objectBoxInstance!;

  Future<List<Food>> getAllFood() {
    try {
      return Future.value(objectBoxInstance.getAllFood());
    } catch (e) {
      throw Exception('Error getting food');
    }
  }
}
