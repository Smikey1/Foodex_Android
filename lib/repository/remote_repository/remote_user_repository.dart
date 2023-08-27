import 'dart:io';

import 'package:foodex_app/app/constraints/network_connection.dart';
import 'package:foodex_app/data/local_data_source/export-local-data.dart';
import 'package:foodex_app/data/remote_data_source/api/user_api.dart';
import 'package:foodex_app/model/export_model.dart';
import 'package:foodex_app/response/user_response.dart';

class UserRepository {
  Future<bool> registerUser(User user) async {
    return await UserAPI().registerUser(user);
  }

  Future<bool?> loginUser(String phoneNumber, String password) async {
    // return await UserAPI().loginUser(phoneNumber, password);
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return UserAPI().loginUser(phoneNumber, password);
    } else {
      return UserDataSource().loginUser(phoneNumber, password);
    }
  }

  Future<UserProfileResponse?> getUserProfile() async {
    return await UserAPI().getUserProfile();
  }

  Future<bool> updateUserProfileWithImage(User user, File imageFile) async {
    return await UserAPI().updateUserProfileWithImage(user, imageFile);
  }

  Future<bool> updateUserProfile(User user) async {
    return await UserAPI().updateUserProfile(user);
  }

  Future<bool?> deleteUserProfile() async {
    return await UserAPI().deleteUser();
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    return await UserAPI().changePassword(oldPassword, newPassword);
  }

  Future<List<Food>?> getUserWishlistProduct() async {
    return await UserAPI().getUserWishlistProduct();
  }

  Future<bool> addToWishlist(String productId) async {
    return await UserAPI().addToWishlist(productId);
  }
}
