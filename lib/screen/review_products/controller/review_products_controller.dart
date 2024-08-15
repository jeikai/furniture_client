import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/repository/user_repository.dart';
import 'package:get/get.dart';

import '../../../data/models/review.dart';
import '../../../data/repository/review_repository.dart';

class ReviewProductsController extends GetxController {
  late Product product;
  bool load = false;

  List<Review> reviews = [];
  @override
  void onInit() {
    super.onInit();
    product = Get.arguments['product'];
    upViewProduct();
    _loadReview();
  }

  Future<void> _loadReview() async {
    load = true;
    reviews = await ReviewRepository().getReviewsByProduct(product);
    update();
  }

  Future<void> upViewProduct() async {
    await UserRepository().seemProduct(product);
  }
}
