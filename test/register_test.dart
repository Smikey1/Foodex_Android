import 'package:flutter_test/flutter_test.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/repository/remote_repository/export_remote_repo.dart';

void main() {
  test('User should be able to login', () async {
    bool expectedResult = true;
    String phone = "1234567890";
    String password = "k1234567890";
    bool? actualResult = await UserRepository().loginUser(phone, password);
    expect(actualResult, expectedResult);
  });

  test("sign Up", () async {
    bool expectedResult = true;
    String fullName = "karma";
    String email = "karma@gmail.com";
    String dob = "2021-09-09";
    String phone = "1234567990";
    String password = "k1234567890";
    String avatar = "";

    User user = User(
      fullName,
      email,
      dob,
      phone,
      password,
      avatar,
    );

    bool actualResult = await UserRepository().registerUser(user);
    expect(actualResult, expectedResult);
  });
}
