import 'package:date_format/date_format.dart';
import 'package:furniture_app/data/models/Discount.dart';
import 'package:furniture_app/data/repository/discount_repository.dart';
import 'package:furniture_app/data/values/images.dart';
import 'package:get/get.dart';

class DiscountController extends GetxController {
  List<MyDiscount> discounts = [];
  List<MyDiscount> discountsAllow = [];
  List<MyDiscount> discountsNotAllow = [];
  bool load = false;

  @override
  void onInit() {
    super.onInit();
    _loadDiscount();
  }

  Future<void> _loadDiscount() async {
    load = true;
    update();
    discounts = await DiscountRepository().getDiscounts();
    if (Get.arguments == null) {
      discountsNotAllow = discounts;
    } else {
      discounts.forEach((element) {
        if (checkDiscount(element)) {
          discountsAllow.add(element);
        } else {
          discountsNotAllow.add(element);
        }
      });
    }
    load = false;
    update();
  }

  bool checkDiscount(MyDiscount discount) {
    double money = Get.arguments;
    if (discount.priceStartAllow > money) return false;
    if (discount.timeStart != null && discount.timeStart!.isAfter(DateTime.now())) return false;
    return true;
  }
}
