import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/state/objectbox_state.dart';

import '../../helper/objectbox.dart';

class UserDataSource {
  ObjectBoxInstance objectBoxInstance = ObjectBoxState.objectBoxInstance!;

// Add User
  Future<int> addUser(User user) async {
    try {
      return objectBoxInstance.addUser(user);
    } catch (e) {
      return Future.value(0);
    }
  }

// Get user data
  Future<List<User>> getUser() async {
    try {
      return Future.value(objectBoxInstance.getAllUser());
    } catch (e) {
      throw Exception('Error getting user');
    }
  }

//  Login user
  Future<bool> loginUser(String phone, String password) {
    try {
      return Future.value(objectBoxInstance.loginUser(phone, password));
    } catch (e) {
      throw Exception(null);
    }
  }

  // Offline Login
  Future addOfflineUser(String phone, String password, User user) async {
    try {
      return objectBoxInstance.addAllUser(phone, password, user);
    } catch (e) {
      return false;
    }
  }
}
