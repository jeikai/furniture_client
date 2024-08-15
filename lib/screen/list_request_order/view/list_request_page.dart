import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/request_order.dart';
import 'package:furniture_app/data/repository/request_repository.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/list_request_order/controller/list_request_order.controller.dart';
import 'package:furniture_app/screen/request_products/view/request_products_page.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListRequestOrderPage extends GetView<ListRequestOrderController> {
  const ListRequestOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListRequestOrderController>(
      builder: (value) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: buildAppBar(),
        body: _buildBody(),
        floatingActionButton: addButton(),
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: Get.width / 5),
          child: Text(
            titleAction,
            style: TextStyle(
              fontFamily: jose_fin_sans,
              color: Colors.black,
              fontSize: Get.width * 0.05,
              fontWeight: FontWeight.w700,
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
        backgroundColor: backgroundColor,
      );

  Widget _buildBody() {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          const Divider(thickness: 5, color: WHITE),
          const SizedBox(height: 5),
          buildMenu(),
          const Divider(thickness: 5, color: WHITE),
          buildContent()
        ],
      ),
    );
  }

  Widget buildMenu() {
    return SizedBox(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(controller.tab.length, (index) => buildItemTab(index, controller.tab[index])),
      ),
    );
  }

  InkWell buildItemTab(int index, String content) {
    return InkWell(
      onTap: () {
        if (index != controller.tabCurrentIndex.value) {
          controller.onChangePage(index);
        }
      },
      child: Column(
        children: [
          Text(
            content,
            style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w600, fontSize: 16, color: index == controller.tabCurrentIndex.value ? Colors.black : Colors.grey),
          ),
          index == controller.tabCurrentIndex.value
              ? Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(50)),
                )
              : Container(),
        ],
      ),
    );
  }

  Container buildContent() {
    return Container(
      width: Get.width,
      height: Get.height - 250,
      child: controller.load
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
              color: Colors.black,
              size: 30,
            ))
          : (controller.orders.length > 0
              ? SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index) {
                        return widgetCustom(controller.orders[index], index);
                      }),
                )
              : Center(
                  child: Text('No request ordered in this state yet'),
                )),
    );
  }

  Widget widgetCustom(RequestOrder item, int index) {
    return Column(
      children: [
        (controller.orders.length != null)
            ? Container(
                color: backgroundColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: Get.width * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            item.id.toString(),
                            style: TextStyle(
                              fontSize: Get.height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            RequestOrderRepository.statusOrderToString(item),
                            style: TextStyle(
                              fontSize: Get.height * 0.02,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      if (index < controller.users.length)
                        Text(
                          'Name customer: ${controller.users[index].name}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: Get.height * 0.02,
                          ),
                        ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Phone: ${item.phone}',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: Get.height * 0.015,
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        'Address shipping:${item.address} ',
                        style: TextStyle(
                          fontSize: Get.height * 0.015,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Divider(),
                      Center(
                        child: GestureDetector(
                          child: Text(
                            detail,
                            style: TextStyle(
                              fontSize: Get.height * 0.015,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onTap: () {
                            //--TODO CLICK DETAIL PRODUCT--
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Text(
                  "No orders yet",
                  style: TextStyle(color: Colors.red, fontSize: 20, fontFamily: nunito_sans),
                ),
              ),
        SizedBox(
          height: Get.height * 0.015,
        ),
      ],
    );
  }

  Widget addButton() {
    return InkWell(
        onTap: () {
          Get.to(const RequestProduct());
        },
        child: Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(top: 20, left: Get.width - 100),
            decoration: const BoxDecoration(color: addButtonColor, shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                color: ColorShadow,
                blurRadius: 20,
                spreadRadius: 4,
              )
            ]),
            child: const Icon(
              Icons.add,
              color: textBlackColor,
            )));
  }
}
