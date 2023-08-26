import 'package:foodex_app/model/export_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path_provider/path_provider.dart';

import '../objectbox.g.dart';

@JsonSerializable()
class ObjectBoxInstance {
  late final Store store;
  late final Box<User> _user;

// ObjectBoxInstance(Store store)

// Creating a constructor
  ObjectBoxInstance(this.store) {
    _user = Box<User>(store);
  }

// ----------- Initialization ObjectBox --------------------------------

  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(
      getObjectBoxModel(),
      directory: '${dir.path}/dashBoardScreen()',
    );
    return ObjectBoxInstance(store);
  }

// ----------- User Query ----------------

  int addUser(User user) {
    return _user.put(user);
  }

  List<User> getAllUser() {
    return _user.getAll();
  }

// ---- Login User ----------------
  bool loginUser(String phone, String password) {
    final userData = _user
        .query(User_.phone.equals(phone) & User_.password.equals(password))
        .build()
        .findFirst();

    return userData == null ? false : true;
  }
}
