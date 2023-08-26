import 'package:foodex_app/data/local_data_source/export-local-data.dart';
import 'package:foodex_app/model/export_model.dart';

abstract class UserRepositoryOB {
  Future<List<User>> getUser();
  Future<int> addUser(User user);

  // Login
  Future<bool?> loginUser(String phone, String password);
}

class UserRepositoryImplementation extends UserRepositoryOB {
  @override
  Future<int> addUser(User user) {
    return UserDataSource().addUser(user);
  }

  @override
  Future<List<User>> getUser() {
    return UserDataSource().getUser();
  }

  @override
  Future<bool?> loginUser(String phone, String password) {
    return UserDataSource().loginUser(phone, password);
  }
}
