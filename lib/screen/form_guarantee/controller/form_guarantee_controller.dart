import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/Order.dart';
import 'package:furniture_app/data/models/guarantee.dart';
import 'package:furniture_app/data/models/guarantee_doing.dart';
import 'package:furniture_app/data/repository/guarantee_repository.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FormGuaranteeController extends GetxController {
  String? code;
  TextEditingController errorText = TextEditingController();
  List<XFile>? images = [];
  List<String> listImagePath = [];
  ImagePicker _picker = ImagePicker();
  late Guarantee guarantees;
  bool loadSubmit = false;
  DateTime now = DateTime.now();
  @override
  void onInit() {
    super.onInit();
    update();
    if (Get.arguments != null && Get.arguments['guarantees'] != null) {
      guarantees = Get.arguments['guarantees'];
    } else {
      guarantees;
    }
  }

  void selectedImage() async {
    images = await _picker.pickMultiImage();
    if (images != null) {
      for (XFile file in images!) {
        listImagePath.add(file.path);
      }
    } else {
      Get.snackbar("Fail", "No Image selected",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: WHITE);
    }
    update();
  }

  void deleteImage(int index) {
    listImagePath.removeAt(index);
    update();
  }

  Future<void> submit() async {
    loadSubmit = true;
    update();
    GuaranteeDoing guarantee = GuaranteeDoing(
        orderID: guarantees.orderID,
        productID: guarantees.productID,
        product: guarantees.product,
        userID: guarantees.userID,
        user: guarantees.user,
        time: now,
        imagePath: listImagePath,
        Error: errorText.text,
        status: [
          StatusOrder(status: "Confirming", date: DateTime.now()),
          StatusOrder(status: "Processing"),
          StatusOrder(status: "Complete"),
        ]);

    await GuaranteeRepository().addGuarantee(guarantee);
    Get.back();
    Get.snackbar('', '',
        titleText: const Text(
          'Submit request successfully',
          style: TextStyle(fontSize: 15, color: textGreenColor),
        ),
        messageText: Row(
          children: [
            const Text('You have product warranty '),
            Text(
              guarantees.product.name.toString(),
              style: TextStyle(color: Colors.red),
            ),
          ],
        ));
    loadSubmit = false;
    update();
  }
}
