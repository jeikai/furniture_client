import 'package:furniture_app/screen/add_payment/controller/add_payment_controller.dart';
import 'package:furniture_app/screen/cart/controller/cart_controller.dart';
import 'package:furniture_app/screen/chat_product/controller/chat_product_controller.dart';
import 'package:furniture_app/screen/discount/controller/discount_controller.dart';
import 'package:furniture_app/screen/discount_detail/controller/discount_detail_controller.dart';
import 'package:furniture_app/screen/edit_profile/controller/edit_profile_controller.dart';
import 'package:furniture_app/screen/game_voucher/controller/game_voucher_controller.dart';
import 'package:furniture_app/screen/guarantee/controller/list_guarantee_controller.dart';
import 'package:furniture_app/screen/list_request_order/controller/list_request_order.controller.dart';
import 'package:furniture_app/screen/password/change_password/change-password_controller.dart';
import 'package:furniture_app/screen/request_products/controller/request_products_controller.dart';
import 'package:furniture_app/screen/setting/controller/setting_controller.dart';
import 'package:get/get.dart';
import 'screen/auth/login/controller/login_controller.dart';
import 'screen/auth/signup/controller/signup_controller.dart';
import 'screen/chatbot/controller/chatbot_controller.dart';
import 'screen/checkout/controller/checkout_controller.dart';
import 'screen/congrats/controller/congrats_controller.dart';
import 'screen/favorite/controller/favorite_controller.dart';
import 'screen/filters/controller/filters_controller.dart';
import 'screen/form_guarantee/controller/form_guarantee_controller.dart';
import 'screen/my_review/controller/my_review_controller.dart';
import 'screen/notification/controller/notification_controller.dart';
import 'screen/payment/controller/payment_controller.dart';
import 'screen/product_detail/controller/product_detail_controller.dart';
import 'screen/add_shipping_address/controller/add_shipping_address_controller.dart';
import 'screen/review_products/controller/review_products_controller.dart';
import 'screen/search_product/controller/search_controller.dart';
import 'screen/shipping_address/controller/shipping_address_controller.dart';
import 'screen/splash/controller/splash_controller.dart';
import 'screen/order/controller/order_controller.dart';
import 'screen/profile/controller/profile_controller.dart';
import 'screen/home/controller.dart/home_controller.dart';
import 'screen/bottom_bar/controller/bottom_bar_controller.dart';
import 'screen/detail_order/controller/detail_order_controller.dart';
import 'screen/write_review/controller/write_review_controller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShippingAddressController>(() => ShippingAddressController(),
        fenix: true);
    Get.lazyPut<AddShippingAddressController>(
        () => AddShippingAddressController(),
        fenix: true);
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<BottomBarController>(() => BottomBarController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<FavoriteController>(() => FavoriteController(), fenix: true);
    Get.lazyPut<ProductDetailController>(() => ProductDetailController(),
        fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<DetailOrderController>(() => DetailOrderController(),
        fenix: true);
    Get.lazyPut<NotificationController>(() => NotificationController(),
        fenix: true);
    Get.lazyPut<FormGuaranteeController>(() => FormGuaranteeController(),
        fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
    Get.lazyPut<CheckoutController>(() => CheckoutController(), fenix: true);
    Get.lazyPut<ReviewProductsController>(() => ReviewProductsController(),
        fenix: true);
    Get.lazyPut<MyReviewController>(() => MyReviewController(), fenix: true);
    Get.lazyPut<FiltersController>(() => FiltersController(), fenix: true);
    Get.lazyPut<RequestProductsController>(() => RequestProductsController(),
        fenix: true);
    Get.lazyPut<CartController>(() => CartController(), fenix: true);
    Get.lazyPut<ShippingAddressController>(() => ShippingAddressController(),
        fenix: true);
    Get.lazyPut<AddShippingAddressController>(
        () => AddShippingAddressController(),
        fenix: true);
    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
    Get.lazyPut<ChatBotController>(() => ChatBotController(), fenix: true);
    Get.lazyPut<SearchPageController>(() => SearchPageController(),
        fenix: true);
    Get.lazyPut<ChatProductController>(() => ChatProductController(),
        fenix: true);
    Get.lazyPut<CongratsController>(() => CongratsController(), fenix: true);
    Get.lazyPut<EditProfileController>(() => EditProfileController(),
        fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
    Get.lazyPut<PaymentController>(() => PaymentController(), fenix: true);
    Get.lazyPut<AddPaymentController>(() => AddPaymentController(),
        fenix: true);
    Get.lazyPut<DiscountController>(() => DiscountController(), fenix: true);
    Get.lazyPut<DiscountDetailController>(() => DiscountDetailController(),
        fenix: true);
    Get.lazyPut<GameVoucherController>(() => GameVoucherController(),
        fenix: true);
    Get.lazyPut<AddPaymentController>(() => AddPaymentController(),
        fenix: true);
    Get.lazyPut<ListGuaranteeController>(() => ListGuaranteeController(),
        fenix: true);
    Get.lazyPut<WriteReviewController>(() => WriteReviewController(),
        fenix: true);
    Get.lazyPut<DiscountDetailController>(() => DiscountDetailController(),
        fenix: true);
    Get.lazyPut<GameVoucherController>(() => GameVoucherController(),
        fenix: true);
    Get.lazyPut<AddPaymentController>(() => AddPaymentController(),
        fenix: true);
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController(),
        fenix: true);
    Get.lazyPut<ListRequestOrderController>(() => ListRequestOrderController(),
        fenix: true);
  }
}
