import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/Discount.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/images.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/discount/controller/discount_controller.dart';
import 'package:furniture_app/screen/discount_detail/view/discount_detail_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DiscountPage extends GetView<DiscountController> {
  const DiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscountController>(
        builder: (value) => Scaffold(
              appBar: appBarCustom(),
              backgroundColor: backgroundColor,
              body: controller.load
                  ? Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.topCenter,
                      child: LoadingAnimationWidget.discreteCircle(
                        color: Colors.white,
                        size: 30,
                      ),
                    )
                  : buildBody(),
            ));
  }

  Container buildBody() {
    return Container(
        height: Get.height,
        padding: EdgeInsets.all(Get.height * 0.018),
        child: SingleChildScrollView(
            child: Column(
          children: [
            if (controller.discountsAllow.length > 0)
              Column(
                children: List.generate(
                  controller.discountsAllow.length,
                  (index) => InkWell(
                    onTap: () {
                      Get.back(result: controller.discountsAllow[index]);
                    },
                    child: buildItem(controller.discountsAllow[index], true),
                  ),
                ),
              ),
            if (controller.discountsNotAllow.length > 0)
              Column(
                children: List.generate(
                  controller.discountsNotAllow.length,
                  (index) => buildItem(controller.discountsNotAllow[index], false),
                ),
              ),
          ],
        )));
  }

  Column buildItem(MyDiscount discount, bool check) {
    return Column(
      children: [
        Container(
          width: Get.width,
          height: Get.height * 0.14,
          padding: EdgeInsets.only(
            top: Get.height * 0.017,
            right: Get.height * 0.013,
            left: Get.height * 0.026,
          ),
          margin: EdgeInsets.only(bottom: Get.height * 0.005, top: Get.height * 0.005),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: check
                      ? [
                          buttonColor,
                          Colors.white,
                          buttonColor
                        ]
                      : [
                          textGrey4Color,
                          Colors.white,
                          textGrey2Color
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [
                    0,
                    0.2,
                    0.6
                  ]),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: check ? buttonColor : Colors.grey)),
          child: _buildInfo(discount),
        ),
      ],
    );
  }

  Column _buildInfo(MyDiscount discount) {
    String timeS = DateFormat('dd/MM/yyyy').format(discount.timeStart!);
    String timeE = DateFormat('dd/MM/yyyy').format(discount.timeEnd!);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(height: Get.height * 0.08, width: Get.height * 0.1, padding: EdgeInsets.only(right: Get.height * 0.012), child: Image.asset(dis20)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.height * 0.29,
                    child: Text(
                      discount.name.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: Get.height * 0.021,
                        color: Colors.black,
                        fontFamily: jose_fin_sans,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.012,
                  ),
                  Row(
                    children: [
                      Text(
                        'Effective:',
                        style: TextStyle(
                          fontSize: Get.height * 0.016,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      // InkWell(
                      //   onTap: () {
                      //     Get.to(const DiscountDetailPage());
                      //   },
                      //   child: const Icon(
                      //     Icons.navigate_next_rounded,
                      //     color: Colors.black,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.002,
                  ),
                  Text(
                    '${timeS}  -  ${timeE}',
                    style: TextStyle(
                      fontSize: Get.height * 0.016,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
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
