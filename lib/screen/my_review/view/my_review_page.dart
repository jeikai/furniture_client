import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/review.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/my_review/controller/my_review_controller.dart';
import 'package:furniture_app/screen/write_review/view/write_review_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class MyReviewPage extends GetView<MyReviewController> {
  const MyReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyReviewController>(
      builder: (value) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        titleReview,
        maxLines: 1,
        style: TextStyle(
          color: textHeaderColor,
          fontSize: Get.width * 0.05,
          fontWeight: FontWeight.w700,
          fontFamily: 'JosefinSans',
        ),
      ),
      leading: InkWell(
        onTap: () => Get.back(),
        child: Padding(
          padding: EdgeInsets.only(left: Get.width * 0.05),
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: Get.width * 0.05,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
    );
  }

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
          Expanded( // Thêm Expanded ở đây
            child: (controller.tabCurrentIndex.value == 2)
                ? buildSellerReview()
                : buildContent(),
          ),
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
        children: List.generate(controller.tab.length,
            (index) => buildItemTab(index, controller.tab[index])),
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
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: index == controller.tabCurrentIndex.value
                    ? Colors.black
                    : Colors.grey),
          ),
          index == controller.tabCurrentIndex.value
              ? Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildContent() {
    return SizedBox(
        width: Get.width,
        height: Get.height - 156,
        child: SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.reviews.length,
              itemBuilder: (context, index) {
                return buildItem(controller.reviews[index], index);
              }),
        ));
  }

  Widget buildItem(Review item, index) {
    return SizedBox(
      width: Get.width,
      height: 205,
      child: SingleChildScrollView(
        // Add SingleChildScrollView to enable scrolling if needed
        child: Column(
          children: [
            if (controller.reviews.isNotEmpty)
              Container(
                color: backgroundColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: Get.width * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      statusOrder(item),
                      const Divider(),
                      infoProducts(item),
                      const Divider(),
                      review(item),
                    ],
                  ),
                ),
              )
            else
              Center(
                child: Text(
                  "No review yet",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontFamily: nunito_sans,
                  ),
                ),
              ),
            const Divider(thickness: 5, color: WHITE),
          ],
        ),
      ),
    );
  }

  Row statusOrder(Review item) {
    return Row(
      children: [
        Text(
          item.orderID.toString(),
          style: TextStyle(
            fontSize: Get.height * 0.02,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          'Completed',
          style: TextStyle(
            fontSize: Get.height * 0.02,
            fontWeight: FontWeight.w500,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget review(Review item) {
    return item.numberStart == null
        ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(
                      "Product reviews before date: ",
                      style: TextStyle(
                        fontSize: Get.height * 0.015,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    // Text(
                    //   DateFormat('dd/MM/yyyy').format(Jiffy(item.time).add(days: 3).dateTime),
                    //   style: TextStyle(
                    //     fontSize: Get.height * 0.015,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                  ]),
                  const SizedBox(height: 5),
                  Text(
                    'Rate now and get 50 points',
                    style: TextStyle(
                      fontSize: Get.height * 0.015,
                      color: textBlack2Color,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                var result = await Get.to(() => const WriteReviewPage(),
                    arguments: item);
                if (result != null) {
                  controller.loadData();
                }
              },
              child: Container(
                margin: const EdgeInsets.only(left: 18),
                width: 70,
                height: 35,
                color: Colors.red,
                child: Center(
                  child: Text("Review",
                      style: TextStyle(
                        color: WHITE,
                        fontSize: Get.height * 0.02,
                      )),
                ),
              ),
            ),
          ])
        : InkWell(
            onTap: () async {
              var result =
                  await Get.to(() => const WriteReviewPage(), arguments: item);
              if (result != null) {
                controller.loadData();
              }
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Get.width - 120,
                  child: Text(
                    'Review: ${item.content}',
                  ),
                ),
                const Spacer(),
                Container(
                  width: 70,
                  height: 35,
                  color: textGrey5Color,
                  child: Center(
                    child: Text("Done",
                        style: TextStyle(
                          color: WHITE,
                          fontSize: Get.height * 0.02,
                        )),
                  ),
                ),
              ],
            ),
          );
  }

  Row infoProducts(Review item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(
              image: NetworkImage(
                item.product.imagePath != null &&
                        item.product.imagePath!.isNotEmpty
                    ? item.product.imagePath![0]
                    : 'https://scontent.fhan19-1.fna.fbcdn.net/v/t39.30808-6/457520415_3653543601624471_7425025362526940664_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=aa7b47&_nc_eui2=AeEWVi3AS8YACcdtraYC-6hDmEIlkDzus9GYQiWQPO6z0fjXWxwoXqSzUez6pa6nef9ypGmPraV5ELkU_GZomoXS&_nc_ohc=e39af-a43dMQ7kNvgHHMLje&_nc_ht=scontent.fhan19-1.fna&oh=00_AYBE9ALHbtqvIzJJ176Hs2Rojcw4V9ug5dsNC2xOQY4Gzg&oe=66D76945', // Hình ảnh mặc định
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width - 200,
                  margin: const EdgeInsets.only(bottom: 10, left: 10),
                  child: Text(
                    item.product.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.height * 0.02,
                    ),
                  ),
                ),
                SizedBox(
                  width: 75,
                  child: Center(
                    child: Text(
                      '\$${item.product.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: Get.height * 0.02,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 10),
              child: Text(
                '${item.product.length} x ${item.product.width} x ${item.product.height}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: Get.height * 0.02,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSellerReview() {
    return SizedBox(
        width: Get.width,
        height: Get.height - 156,
        child: SingleChildScrollView(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.reviews.length,
              itemBuilder: (context, index) {
                return buildItemSeller(controller.reviews[index]);
              }),
        ));
  }

  Widget buildItemSeller(Review value) {
    return SizedBox(
        width: Get.width,
        child: Column(
          children: [
            (controller.reviews.length != null)
                ? Container(
                    color: backgroundColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: Get.width * 0.04),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 10),
                            statusOrder(value),
                            const Divider(),
                            infoProducts(value),
                            const Divider(),
                            SizedBox(
                              width: Get.width - 120,
                              child: Text(
                                'Review: ${value.content}',
                              ),
                            ),
                            const Divider(),
                            reply(value),
                          ]),
                    ),
                  )
                : Center(
                    child: Text(
                    "No review yet",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontFamily: nunito_sans),
                  )),
            const Divider(thickness: 5, color: WHITE),
          ],
        ));
  }

  Row reply(Review value) {
    return Row(
      children: [
        SizedBox(
          width: Get.width - 110,
          child: Text(
            '${value.reply}',
            style: TextStyle(
              fontFamily: nunito_sans,
              fontSize: 18,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            var result =
                await Get.to(() => const WriteReviewPage(), arguments: value);
            if (result != null) {
              controller.loadData();
            }
          },
          child: Container(
            width: 70,
            height: 35,
            color: buttonColor,
            child: Center(
              child: Text("Detail",
                  style: TextStyle(
                    color: WHITE,
                    fontSize: Get.height * 0.02,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
