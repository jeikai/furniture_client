import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:furniture_app/data/auth/auth_service.dart';
import 'package:furniture_app/data/models/Order.dart';
import 'package:furniture_app/data/models/request_order.dart';
import 'package:furniture_app/data/repository/request_repository.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/values/colors.dart';

class RequestProductsController extends GetxController {
  TextEditingController addressText = TextEditingController();
  TextEditingController phoneText = TextEditingController();
  TextEditingController noteText = TextEditingController();
  TextEditingController nameText = TextEditingController();
  TextEditingController priceText = TextEditingController();
  TextEditingController timeText = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String> listImagePath = [];

  int? selectedType;
  bool submitLoadButton = false;

  void onSelecteType(int? value) {
    if (value == 1) {
      selectedType = 1;
    } else if (value == 2) {
      selectedType = 2;
      update();
    }
    update();
  }

  void selectedImage() async {
    images = await _picker.pickMultiImage();
    if (images != null) {
      for (XFile file in images!) {
        listImagePath.add(file.path);
      }
    } else {
      Get.snackbar(
        "Fail",
        "No Image selected",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: WHITE,
      );
    }
    update();
  }

  void deleteImage(int index) {
    listImagePath.removeAt(index);
    update();
  }

  Future<void> clickSubmitButton() async {
    if (submitLoadButton == false) {
      submitLoadButton = true;
      update();
      RequestOrder order = RequestOrder(
        address: addressText.text,
        priceOrder: double.parse(priceText.text),
        phone: phoneText.text,
        note: noteText.text,
        name: nameText.text,
        imagePath: listImagePath,
        userID: AuthService.userId,
        status: [
          StatusOrder(status: "Ordered", date: DateTime.now()),
          StatusOrder(status: "Preparing"),
          StatusOrder(status: "Delivery"),
          StatusOrder(status: "Completed"),
          StatusOrder(status: "Cancel")
        ],
      );
      await RequestOrderRepository().addToOrder(order);
      Get.snackbar("Add successfully", "");
      reload();
      submitLoadButton = false;
      update();
    }
  }

  void reload() {
    addressText.clear();
    phoneText.clear();
    noteText.clear();
    nameText.clear();
    priceText.clear();
    listImagePath = [];
  }
}
