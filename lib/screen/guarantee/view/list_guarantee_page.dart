import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/guarantee.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/form_guarantee/view/form_guarantee_page.dart';
import 'package:furniture_app/screen/guarantee/controller/list_guarantee_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../../../data/models/guarantee_doing.dart';

class ListGuaranteePage extends GetView<ListGuaranteeController> {
  const ListGuaranteePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListGuaranteeController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                  elevation: 0,
                  backgroundColor: backgroundColor,
                  title: Padding(
                    padding: EdgeInsets.only(left: Get.width / 6),
                    child: Text(
                      list_guarantee,
                      style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.w800,
                        fontSize: Get.width * 0.039,
                        color: textBlackColor,
                      ),
                    ),
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
                  actions: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.search,
                        color: textBlackColor,
                      ),
                    ),
                  ]),
              body: Container(
                color: backgroundColor,
                child: buildBody(),
              ),
            ));
  }

  Widget buildBody() {
    return Container(
      child: Column(children: [
        buildMenu(),
        Expanded(
          child: (controller.selectedTab == 1)
              ? Container(
                  color: backgroundColor,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.guaranteesDoing.length,
                        itemBuilder: (context, index) {
                          return buildContentD(
                              controller.guaranteesDoing[index]);
                        }),
                  ),
                )
              : Container(
                  color: backgroundColor,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.guarantees.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              if (controller.selectedTab == 0) {
                                Get.to(const FormGuaranteePage(), arguments: {
                                  'guarantees': controller.guarantees[index]
                                });
                              }
                            },
                            child: buildContent(controller.guarantees[index]),
                          );
                        }),
                  )),
        ),
      ]),
    );
  }

  Widget buildGuaranteeDoing() {
    return Container(color: Colors.green, child: Text('o9999999999999'));
  }

  Widget buildMenu() {
    return Container(
        color: backgroundColor,
        padding: EdgeInsets.only(
          bottom: 15,
          left: Get.width * 0.007,
        ),
        child: DefaultTabController(
          length: 3,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  color: backgroundColor,
                  constraints: BoxConstraints.expand(height: Get.height * 0.05),
                  child: TabBar(
                      onTap: (index) {
                        controller.onChangePage(index);
                      },
                      isScrollable: true,
                      controller: controller.tabController,
                      indicatorColor: order_color,
                      tabs: [
                        SizedBox(
                          width: Get.width * 0.22,
                          child: Text(
                            tab1,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: jose_fin_sans,
                                fontWeight: FontWeight.w800,
                                fontSize: Get.width * 0.039,
                                color: textBlackColor),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.22,
                          child: Text(
                            tab2,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: jose_fin_sans,
                                fontWeight: FontWeight.w800,
                                fontSize: Get.width * 0.039,
                                color: textBlackColor),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.22,
                          child: Text(
                            tab3,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: jose_fin_sans,
                                fontWeight: FontWeight.w800,
                                fontSize: Get.width * 0.039,
                                color: textBlackColor),
                          ),
                        ),
                      ]),
                ),
              ]),
        ));
  }

  Widget buildContentD(GuaranteeDoing guaranteeDoing) {
    return Container(
      width: Get.width - Get.height * 0.05,
      padding: EdgeInsets.only(
        bottom: 10.0,
        top: 10,
      ),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: ColorShadow,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: Get.width * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID Order: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.width * 0.039,
                  ),
                ),
                Expanded(
                  child: Text(
                    guaranteeDoing.userID,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.width * 0.039,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: EdgeInsets.all(Get.height * 0.009),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.13,
                  width: Get.height * 0.13,
                  child: Image.network(
                    guaranteeDoing.product.imagePath!.isNotEmpty
                        ? guaranteeDoing.product.imagePath!.first
                        : 'https://scontent.fhan19-1.fna.fbcdn.net/v/t39.30808-6/457549306_1044188777090033_865691948350707320_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=bd9a62&_nc_eui2=AeERE8oNLhjS4k2PYCKwjy48t4-O28DNALK3j47bwM0AsokNiXWIniciSuOjr9odQFqxAkWvSFXS6OfyVBxOjDM_&_nc_ohc=Zb1_Y__NOAMQ7kNvgG1cene&_nc_ht=scontent.fhan19-1.fna&oh=00_AYBP94C0Bwhl92hKp0zgSRYzNhGeMQS0DWRrQmSx4giXGg&oe=66D5AD5A',
                    // Replace with your default image URL
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: Get.height * 0.026,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        guaranteeDoing.product.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: Get.width * 0.039,
                          color: textBlack2Color,
                        ),
                      ),
                      Text(
                        'Price:  \$${guaranteeDoing.product.price.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.039,
                          color: textGrey3Color,
                        ),
                      ),
                      Text(
                        'Start date: ${DateFormat('dd/MM/yyyy').format(guaranteeDoing.time)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.039,
                          color: textGrey3Color,
                        ),
                      ),
                      // Text(
                      //   'End date: ${DateFormat('dd/MM/yyyy').format(calculateGuaranteeEndDate(guaranteeDoing.time))}',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: Get.width * 0.039,
                      //     color: textGrey3Color,
                      //   ),
                      //),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent(Guarantee guarantee) {
    return Container(
      width: Get.width - Get.height * 0.05,
      padding: EdgeInsets.only(
        bottom: 10.0,
        top: 10,
      ),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: ColorShadow,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: Get.width * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID Order: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.width * 0.039,
                  ),
                ),
                Expanded(
                  child: Text(
                    guarantee.userID,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.width * 0.039,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: EdgeInsets.all(Get.height * 0.009),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.13,
                  width: Get.height * 0.13,
                  child: Image.network(
                    guarantee.product.imagePath!.isNotEmpty
                        ? guarantee.product.imagePath!.first
                        : 'https://scontent.fhan19-1.fna.fbcdn.net/v/t39.30808-6/457549306_1044188777090033_865691948350707320_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=bd9a62&_nc_eui2=AeERE8oNLhjS4k2PYCKwjy48t4-O28DNALK3j47bwM0AsokNiXWIniciSuOjr9odQFqxAkWvSFXS6OfyVBxOjDM_&_nc_ohc=Zb1_Y__NOAMQ7kNvgG1cene&_nc_ht=scontent.fhan19-1.fna&oh=00_AYBP94C0Bwhl92hKp0zgSRYzNhGeMQS0DWRrQmSx4giXGg&oe=66D5AD5A', // Replace with your default image URL
                    fit: BoxFit.cover,
                  ),

                ),
                SizedBox(
                  width: Get.height * 0.026,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        guarantee.product.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: Get.width * 0.039,
                          color: textBlack2Color,
                        ),
                      ),
                      Text(
                        'Price:  \$${guarantee.product.price.toString()}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.039,
                          color: textGrey3Color,
                        ),
                      ),
                      Text(
                        'Start date: ${DateFormat('dd/MM/yyyy').format(guarantee.time)}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: Get.width * 0.039,
                          color: textGrey3Color,
                        ),
                      ),
                      // Text(
                      //   'End date: ${DateFormat('dd/MM/yyyy').format(calculateGuaranteeEndDate(guarantee.time))}',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: Get.width * 0.039,
                      //     color: textGrey3Color,
                      //   ),
                      //),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//   DateTime calculateGuaranteeEndDate(DateTime startDate) {
//     return Jiffy(startDate).add(months: 3).dateTime;
//   }
}
