import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/repository/user_repository.dart';
import 'package:get/get.dart';
import '../../../data/models/review.dart';
import '../../../data/repository/review_repository.dart';

class ProductDetailController extends GetxController {
  late Product product;
  List<Review> reviews = [];
  int currentIndexImage = 0;
  late PageController pageViewController;
  int number = 1;
  late int favorite;
  late int cart;
  bool statusCart = true;
  bool changed = false;
  double numberStart = 0;
  @override
  void onInit() {
    super.onInit();
    product = Get.arguments['product'];
    favorite = Get.arguments['favorite'] ? 1 : 0;
    pageViewController = PageController(initialPage: 0);
    loadData();
    // _loadReview();
  }

  // Future<void> _loadReview() async {
  //   //load = true;
  //   reviews = await ReviewRepository().getReviewsByProduct(product);
  // }

  Future<void> loadData() async {
    reviews = await ReviewRepository().getReviewsByProduct(product);
    if (reviews.length > 0) {
      double total = 0;
      for (int i = 0; i < reviews.length; i++) {
        total += reviews[i].numberStart ?? 0;
      }
      if (total > 0) {
        numberStart = total / reviews.length;
        product.numberStart = numberStart;
        product.totalReview = reviews.length;
      }
    }
    update();
    await UserRepository().seemProduct(product);
  }

  String getImagePath() {
    return product.imagePath?[currentIndexImage] ?? "";
  }

  Color getImageColorTheme() {
    return product.imageColorTheme?[currentIndexImage] ?? Colors.black;
  }

  void onChangedImagePage(int index) {
    currentIndexImage = index;
    update();
  }

  void onChangedImageColor(int index) {
    pageViewController.jumpToPage(index);
    currentIndexImage = index;
    update();
  }

  void subtractNumber() {
    number = number - 1;
    update();
  }

  void plusNumber() {
    number = number + 1;
    update();
  }

  void changeFavorite() {
    favorite = 1 - favorite;
    update();
  }

  Future<void> clickFavorites() async {
    changed = true;
    changeFavorite();
    UserRepository().updateFavorite(product.id.toString(), favorite == 1);
  }

  Future<void> clickCart() async {}
}
