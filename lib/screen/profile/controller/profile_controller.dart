import 'package:flutter/material.dart';
import 'package:furniture_app/data/auth/auth_service.dart';
import 'package:furniture_app/data/models/user_profile.dart';
import 'package:furniture_app/data/values/images.dart';
import 'package:furniture_app/screen/auth/login/view/login_page.dart';
import 'package:get/get.dart';
import '../../../data/repository/user_repository.dart';

class ProfileController extends GetxController {
  UserProfile users = UserProfile(name: "", email: "");
  int count = 0;

  @override
  void onInit() {
    super.onInit();
    print("onInit của User");
    loadData();
  }

  Future<void> loadData() async {
    users = await UserRepository().getUserProfile();
    print("Init user");
    print(users);
    update();
  }

  Future<void> logout() async {
    await AuthService.signOut();
    Get.to(LoginPage());
  }

  getAvatar() {
    if (users.avatarPath != null) return NetworkImage(users.avatarPath!);
    return AssetImage(avatar);
  }

}