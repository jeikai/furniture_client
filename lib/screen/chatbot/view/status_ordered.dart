// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/Order.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/screen/chatbot/controller/chatbot_controller.dart';
import 'package:get/get.dart';

class StatusOrderedPage extends GetView<ChatBotController> {
  MyOrder order;
  String status;
  StatusOrderedPage({super.key, required this.order, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.height * 0.024),
      margin: EdgeInsets.only(
        top: 14,
        bottom: 14,
        left: 10,
        right: Get.width * 0.1 + 10,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: buttonColor,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your order status: $status",
            style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w600, fontSize: Get.height * 0.025, color: Colors.black),
          ),
          Text("The order has been successfully placed.", maxLines: 3, textAlign: TextAlign.justify, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, color: textGrey)),
          Text("The shop will soon prepare and ship your order to you in the next few days.", maxLines: 3, textAlign: TextAlign.justify, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, color: textGrey)),
          const Text("Thank you !", maxLines: 3, textAlign: TextAlign.justify, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, color: textGrey)),
          const Divider(),
          SizedBox(height: Get.height * 0.006),
        ],
      ),
    );
  }
}
