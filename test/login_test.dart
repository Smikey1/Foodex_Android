import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodex_app/data/remote_data_source/api/user_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({
      "login":
          "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzZWUxZTNmZDVlYzMwMzhhYjc0MjhhMCIsImlhdCI6MTY3NjU2MjEyOSwiZXhwIjoxNjc2NjQ4NTI5fQ.Unde-U2EJ_iiL6KoxRdnIYLylSUHq9Q6Yi8E1e-BtKM"
    });
  });
  WidgetsFlutterBinding.ensureInitialized();

  test('User should be able to log in', () async {
    bool expectedResult = true;
    String phone = "1234567890";
    String password = "k1234567890";
    bool actualResult = await UserAPI().loginUser(phone, password);
    expect(actualResult, expectedResult);
  });
}
