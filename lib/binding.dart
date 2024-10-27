import 'package:furniture_app/screen/cart/controller/cart_controller.dart';
import 'package:furniture_app/screen/chat_product/controller/chat_product_controller.dart';
import 'package:furniture_app/screen/profile/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'screen/auth/login/controller/login_controller.dart';
import 'screen/auth/signup/controller/signup_controller.dart';
import 'screen/favorite/controller/favorite_controller.dart';
import 'screen/filters/controller/filters_controller.dart';
import 'screen/my_review/controller/my_review_controller.dart';
import 'screen/product_detail/controller/product_detail_controller.dart';
import 'screen/review_products/controller/review_products_controller.dart';
import 'screen/search_product/controller/search_controller.dart';
import 'screen/splash/controller/splash_controller.dart';
import 'screen/home/controller.dart/home_controller.dart';
import 'screen/bottom_bar/controller/bottom_bar_controller.dart';
import 'screen/write_review/controller/write_review_controller.dart';
import 'package:furniture_app/screen/edit_profile/controller/edit_profile_controller.dart';
import 'package:furniture_app/screen/setting/controller/setting_controller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomBarController>(() => BottomBarController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<FavoriteController>(() => FavoriteController(), fenix: true);
    Get.lazyPut<ProductDetailController>(() => ProductDetailController(),
        fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<EditProfileController>(() => EditProfileController(),
        fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
    Get.lazyPut<ReviewProductsController>(() => ReviewProductsController(),
        fenix: true);
    Get.lazyPut<MyReviewController>(() => MyReviewController(), fenix: true);
    Get.lazyPut<FiltersController>(() => FiltersController(), fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
    Get.lazyPut<SearchPageController>(() => SearchPageController(),
        fenix: true);
    Get.lazyPut<ChatProductController>(() => ChatProductController(),
        fenix: true);
    Get.lazyPut<WriteReviewController>(() => WriteReviewController(),
        fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
  }
}
