import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/notification.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/detail_order/view/detail_order_page.dart';
import 'package:furniture_app/screen/notification/controller/notification_controller.dart';
import 'package:get/get.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(),
            ));
  }

  Container buildBody() {
    return Container(
        width: Get.width,
        height: Get.height,
        child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  height: 1.3,
                  thickness: 1.3,
                  endIndent: 10,
                  indent: 10,
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
            itemCount: controller.notifications.length,
            itemBuilder: (BuildContext context, int index) {
              return buildItem(controller.notifications[index]);
            }));
  }

  Container buildItem(MyNotiInformation notiInformation) => Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: notiInformation.isSeemed == false
              ? const Color.fromRGBO(240, 240, 240, 0.7)
              : null,
          boxShadow: const [
            BoxShadow(
              color: ColorShadow,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            controller.loadOrder(notiInformation.orderId.toString());
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/logo_user.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width - 140,
                    child: Text(
                      "Your order #${notiInformation.orderId} has been ${notiInformation.orderStatus}",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          fontFamily: jose_fin_sans),
                    ),
                  ),
                  Container(
                    width: Get.width - 120,
                    child: Text(
                      notiInformation.message.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: jose_fin_sans,
                          fontSize: 14,
                          color: textGrey3Color),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  AppBar appBarCustom() {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Align(
        child: Text(
          notification,
          style: TextStyle(
              fontFamily: gelasio,
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: textBlackColor.withOpacity(0.8)),
        ),
      ),
    );
  }
}
