import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/Discount.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/images.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/discount_detail/controller/discount_detail_controller.dart';
import 'package:get/get.dart';

class DiscountDetailPage extends GetView<DiscountDetailController> {
  const DiscountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscountDetailController>(
        builder: (value) => Scaffold(
              appBar: appBarCustom(),
              body: buildBody(),
            ));
  }

  Container buildBody() {
    return Container(
      height: Get.height,
      color: backgroundColor,
      padding: EdgeInsets.all(Get.height * 0.018),
      child: Column(
        children: [
          disDetailCustom(),
        ],
      ),
    );
  }

  Widget disDetailCustom() {
    return Container(
      height: Get.height * 0.791,
      width: Get.width,
      child: Stack(children: [
        Container(
            width: Get.width - 16 * 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildItem(controller.discount1),
              ],
            )),
      ]),
    );
  }

  Column buildItem(MyDiscount discount) {
    return Column(children: [
      Image.asset(dis20),
      SizedBox(height: Get.height * 0.033),
      Container(
        padding: EdgeInsets.all(Get.height * 0.026),
        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              discount.name.toString(),
              style: TextStyle(
                fontSize: Get.height * 0.05,
                color: Colors.black,
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            SizedBox(height: Get.height * 0.026),
            Text(
              effective + ':',
              style: TextStyle(
                fontSize: Get.height * 0.02,
                color: Colors.black,
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${discount.timeStart} - ${discount.timeEnd}',
              style: TextStyle(
                fontSize: Get.height * 0.024,
                color: Colors.black,
                fontFamily: jose_fin_sans,
              ),
            ),
            SizedBox(height: Get.height * 0.026),
            Text(
              '$condition:',
              style: TextStyle(
                fontSize: Get.height * 0.02,
                color: Colors.black,
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      title: Text(
        discount,
        style: TextStyle(fontFamily: 'JosefinSans', fontWeight: FontWeight.w800, fontSize: Get.width * 0.045, color: textBlackColor),
      ),
      leading: InkWell(
        onTap: () {
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: textBlackColor,
        ),
      ),
    );
  }
}
