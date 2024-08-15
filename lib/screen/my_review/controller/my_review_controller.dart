import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/models/review.dart';
import 'package:furniture_app/data/models/user_profile.dart';
import 'package:furniture_app/data/repository/review_repository.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class MyReviewController extends GetxController {
  List<String> tab = [
    "Not yet rated",
    "Have evaluated",
    "Seller reviews"
  ];
  Rx<int> tabCurrentIndex = 0.obs;
  bool load = true;
  List<Review> totalReviews = [];
  List<Review> reviews = [];
  List<Review> review = [
    Review(
        orderID: 'sèdfd',
        productID: '',
        product: Product(imagePath: [
          'https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Farmchair%2F4eETjjDxq6BqPei%2Freceived_757563706071981.webp?alt=media&token=4173d2ac-ec11-4d2c-9104-e54a53f8bbc6'
        ]),
        userID: '',
        user: UserProfile(),
        time: DateTime(23, 10, 2001),
        content: "ssjksnd",
        reply: "Thanks")
  ];
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    totalReviews = await ReviewRepository().getReviewsByUser();
    onChangePage(tabCurrentIndex.value);
  }

  void onChangePage(int index) {
    tabCurrentIndex.value = index;
    reviews = [];
    if (index == 0) {
      for (var element in totalReviews) {
        DateTime t = Jiffy.parseFromDateTime(element.time).add(months: 3).dateTime;
        if (t.isAfter(DateTime.now()) && element.numberStart == null) {
          reviews.add(element);
        }
      }
    }
    if (index == 1) {
      for (var element in totalReviews) {
        if (element.numberStart != null && element.numberStart! > 0) {
          reviews.add(element);
        }
      }
    }
    if (index == 2) {
      for (var element in totalReviews) {
        if (element.reply != null) {
          reviews.add(element);
        }
      }
    }
    update();
  }
}
