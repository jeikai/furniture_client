import 'dart:io';
import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/review.dart';
import 'package:furniture_app/data/repository/review_repository.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class WriteReviewController extends GetxController {
  TextEditingController reviewController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile>? images = [];
  List<String> listImagePath = [];
  List<String> listVideoPath = [];
  int ratingNumber = 5;
  late Review review;
  bool loadSubmit = false;
  String status = "Write";

  @override
  void onInit() {
    super.onInit();
    status = "Write";
    if (Get.arguments != null) {
      review = Get.arguments;
      if (review.numberStart != null) {
        status = "Read";
        ratingNumber = review.numberStart!;
        reviewController.text = review.content.toString();
        listImagePath = review.imagePath ?? [];
      }
    } else {
      Get.back();
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

  late File _video;
  void selectedVideo() async {
    XFile? videos = await _picker.pickVideo(source: ImageSource.gallery);
    _video = File(videos!.path);
    // if (videos != null) {
    //   for (XFile file in videos!) {
    //     listVideoPath.add(file.path);
    //   }
    // } else {
    //   Get.snackbar("Fail", "No Image selected",
    //       snackPosition: SnackPosition.TOP,
    //       backgroundColor: Colors.red,
    //       colorText: WHITE);
    // }
    update();
  }

  void deleteImage(int index) {
    listImagePath.removeAt(index);
    update();
  }

  Future<void> submit() async {
    loadSubmit = true;
    update();
    review.numberStart = ratingNumber;
    if (listImagePath.length > 0) review.imagePath = listImagePath;
    if (reviewController.text != '') review.content = reviewController.text;
    await ReviewRepository().updateReview(review);
    status = "Read";
    Get.back();
    loadSubmit = false;
    update();
  }
}
