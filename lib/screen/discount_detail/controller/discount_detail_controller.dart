import 'package:date_format/date_format.dart';
import 'package:furniture_app/data/models/Discount.dart';
import 'package:furniture_app/data/values/images.dart';
import 'package:get/get.dart';

class DiscountDetailController extends GetxController {
  MyDiscount discount1 = MyDiscount(
    id: 0.toString(),
    name: "Discount 20 %",
    percent: 20,
    timeStart: DateTime(15, 05, 2023),
    timeEnd: DateTime(15, 05, 2023),
  );

  @override
  void onInit() {
    super.onInit();
  }
}
