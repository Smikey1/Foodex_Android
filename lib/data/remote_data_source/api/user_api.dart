import 'dart:io';

import 'package:dio/dio.dart';
import 'package:foodex_app/app/constraints/api_url.dart';
import 'package:foodex_app/app/constraints/http_services.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/response/login_response.dart';
import 'package:foodex_app/response/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAPI {
  Future<bool> registerUser(User user) async {
    bool isRegister = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      print("User to JSON-->${user.toJson()}");
      Response response = await dio.post(registerUrl, data: user.toJson());
      if (response.statusCode == 200) {
        isRegister = true;
        return isRegister;
      }
    } catch (exception) {
      print(exception);
    }
    return isRegister;
  }

  Future<bool> loginUser(String phoneNumber, String password) async {
    bool isLogin = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      Map<String, dynamic> userLoginData = {
        "phone": phoneNumber,
        "password": password
      };
      // dio ko response --> server le dine
      Response response = await dio.post(loginUrl, data: userLoginData);
      // response.data
      final LoginResponse loginResponseKoData =
          LoginResponse.fromJson(response.data);
      tokenConstant = loginResponseKoData.token;
      if (response.statusCode == 200) {
        final pref = await SharedPreferences.getInstance();
        pref.setString("token", tokenConstant!);

        isLogin = true;
        return isLogin;
      }
    } catch (exception) {
      print(exception);
    }
    return isLogin;
  }

  // Get single user
  Future<UserProfileResponse?> getUserProfile() async {
    UserProfileResponse? userProfileResponse;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.get("$userUrl/profile",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      // response.data
      userProfileResponse = UserProfileResponse.fromJson(response.data);
      print("The User response is: --> ${userProfileResponse.data}");
      if (userProfileResponse.success == true) {
        return userProfileResponse;
      } else {
        userProfileResponse = null;
      }
    } catch (exception) {
      print(exception);
    }
    return userProfileResponse;
  }

  // Update User Profile
  // Future<bool> updateUserProfile(User user) async {
  //   bool isUserUpdated = false;
  //   Dio dio = HttpServices().getDioInstance();
  //   try {
  //     // dio ko response
  //     Response response = await dio.put(updateProfileUrl,
  //         options: Options(headers: {
  //           HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
  //         }));
  //     final UserProfileResponse userProfileResponseData =
  //         UserProfileResponse.fromJson(response.data);
  //     if (userProfileResponseData.success == true) {
  //       response.statusCode == 200;
  //       isUserUpdated = true;
  //       return isUserUpdated;
  //     }
  //   } catch (exception) {
  //     print(exception);
  //   }
  //   return isUserUpdated;
  // }

  Future<bool> updateUserProfileWithImage(User user, File imageFile) async {
    try {
      Dio dio = HttpServices().getDioInstance();
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        'fullName': user.fullName,
        'email': user.email,
        'phone': user.phone,
        'dob': user.dob,
        "user_image":
            await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });
      print("The Form Data -->$imageFile");

      Response response = await dio.put(
        updateProfileAllUrl,
        data: formData,
        options: Options(
          headers: {
            // "Authorization": Constant.token,
            "Authorization": tokenConstant,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserProfile(User user) async {
    try {
      Dio dio = HttpServices().getDioInstance();

      FormData formData = FormData.fromMap({
        'fullName': user.fullName,
        'email': user.email,
        'phone': user.phone,
        'dob': user.dob,
      });

      Response response = await dio.put(
        updateProfileDataUrl,
        data: formData,
        options: Options(
          headers: {
            "Authorization": tokenConstant,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      Dio dio = HttpServices().getDioInstance();

      FormData formData = FormData.fromMap({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });

      Response response = await dio.post(
        changePasswordUrl,
        data: formData,
        options: Options(
          headers: {
            "Authorization": tokenConstant,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

// Delete user profile
  Future<bool> deleteUser() async {
    bool isUserDelete = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response
      Response response = await dio.delete("$userUrl/delete",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));

      final UserProfileResponse userResponseData =
          UserProfileResponse.fromJson(response.data);
      if (userResponseData.success == true) {
        isUserDelete = true;
        return isUserDelete;
      }
    } catch (exception) {
      print(exception);
    }
    return isUserDelete;
  }

  Future<bool> addToWishlist(String foodId) async {
    bool isAdded = false;
    Dio dio = HttpServices().getDioInstance();
    try {
      // dio ko response --> server le dine
      Response response = await dio.post("$wishlistUrl/$foodId",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      if (response.statusCode == 200) {
        isAdded = true;
        return isAdded;
      }
    } catch (exception) {
      print(exception);
    }
    return isAdded;
  }

  // Wish List
  Future<List<Food>?> getUserWishlistProduct() async {
    Dio dio = HttpServices().getDioInstance();
    List<Food> foodList;
    try {
      // dio ko response --> server le dine
      Response response = await dio.get(wishlistUrl,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $tokenConstant",
          }));
      // response.data

      final parsed = response.data["data"];
      print("The food List is:$parsed");

      List<Food> foodList =
          List<Food>.from(parsed.map((i) => Food.fromJson(i))).toList();
      loggedInUserWishlist = foodList;
      // print("The food List is:$foodList!");

      // userResponse = WishlistResponse.fromJson(myResponseData);

      return foodList;
    } catch (exception) {
      print(exception);
    }
    return null;
  }
}
