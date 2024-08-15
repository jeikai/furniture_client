import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/images.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/congrats/controller/congrats_controller.dart';
import 'package:furniture_app/screen/order/view/order_page.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class CongratsPage extends GetView<CongratsController> {
  const CongratsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CongratsController>(
      builder: (value) => Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.only(top: Get.height * 0.147),
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            success.toUpperCase(),
            style: TextStyle(
                color: Colors.black,
                fontSize: Get.height * 0.042,
                fontWeight: FontWeight.w900,
                fontFamily: jose_fin_sans),
          ),
          SizedBox(height: Get.height * 0.03),
          Image.asset(congrats),
          SizedBox(height: Get.height * 0.03),
          Text(
            order_delivered,
            style: TextStyle(
                color: Colors.grey,
                fontSize: Get.height * 0.023,
                fontWeight: FontWeight.w400,
                fontFamily: jose_fin_sans),
          ),
          Text(
            thank_you,
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: Get.height * 0.023,
                fontFamily: jose_fin_sans),
          ),
          SizedBox(height: Get.height * 0.047),
          trackButton(),
          SizedBox(height: Get.height * 0.03),
          backButton(),
        ],
      ),
    );
  }

  Widget trackButton() {
    return InkWell(
      onTap: () {
        Get.to(OrderPage());
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.023),
        width: Get.height * 0.37,
        height: Get.height * 0.071,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Text(
          track_oder,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: jose_fin_sans,
              fontSize: Get.height * 0.023,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
    );
  }

  Widget backButton() {
    return InkWell(
      onTap: () {
        Get.back();
        Get.back();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.023),
        width: Get.height * 0.37,
        height: Get.height * 0.071,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 1.0),
        ),
        child: Text(
          back_home.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: Get.height * 0.021,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ),
    );
  }
}
