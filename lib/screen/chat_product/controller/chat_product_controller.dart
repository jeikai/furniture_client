import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/message.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/models/user_profile.dart';
import 'package:furniture_app/data/repository/message_repository.dart';
import 'package:furniture_app/data/repository/user_repository.dart';
import 'package:get/get.dart';

class ChatProductController extends GetxController {
  List<Message> mess = [];
  bool loadPage = true;
  TextEditingController messageText = TextEditingController();
  late UserProfile user;
  @override
  void onInit() {
    super.onInit();
    loadMess();
  }

  Future<void> loadMess() async {
    user = await UserRepository().getUserProfile();
    Product? product = Get.arguments;
    if (product != null) {
      await MessageRepository().sendProduct(product, user);
    }
  }

  Future<void> sendMessage() async {
    await MessageRepository().sendMessage(messageText.text, user);
    messageText.clear();

    update();
  }
}
