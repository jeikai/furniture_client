import 'package:flutter/material.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/review_products/controller/review_products_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/models/product.dart';
import '../../../data/models/review.dart';

class ReviewProductsPage extends GetView<ReviewProductsController> {
  const ReviewProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewProductsController>(
      builder: (value) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: buildAppBar(),
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: _buildBody(controller.product)),
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          titleReview,
          style: TextStyle(fontFamily: 'JosefinSans', fontWeight: FontWeight.w800, fontSize: Get.width * 0.039, color: textBlackColor),
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
        backgroundColor: backgroundColor,
      );

  Widget _buildBody(Product product) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025),
          child: Column(
            children: [
              SizedBox(width: double.infinity, height: Get.height * 0.2, child: ratingAndView(product)),
              buildReview(controller),
            ],
          ),
        ),
      );
}

Container buildReview(ReviewProductsController controller) {
  return Container(
    alignment: Alignment.topLeft,
    margin: EdgeInsets.all(Get.height * 0.017),
    width: Get.width,
    child: SingleChildScrollView(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(controller.reviews.length, (index) => commentRating(controller.reviews[index])),
    )),
  );
}

Widget ratingAndView(Product product) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.only(left: Get.width * 0.05),
    child: Row(
      children: [
        Container(
          height: Get.height * 0.18,
          width: Get.height * 0.18,
          child: Image.network(product.imagePath!.first.toString(), fit: BoxFit.cover),
        ),
        SizedBox(
          width: Get.width * 0.05,
        ),
        Container(
          padding: EdgeInsets.only(top: Get.height * 0.01),
          child: SizedBox(
            height: Get.height * 0.13,
            width: Get.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Get.height * 0.022,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'JosefinSans',
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: Get.height * 0.032,
                      width: Get.height * 0.032,
                      child: Image.asset(starIcons),
                    ),
                    SizedBox(
                      width: Get.width * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: Get.height * 0.005),
                      child: Text(
                        product.numberStart.toString(),
                        style: TextStyle(
                          fontSize: Get.height * 0.04,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'JosefinSans',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  '${product.totalReview} Reviews',
                  style: TextStyle(fontFamily: 'JosefinSans', fontWeight: FontWeight.w400, fontSize: Get.height * 0.028),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget commentRating(Review review) {
  return Column(
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: Get.height * 0.3,
            padding: EdgeInsets.all(Get.width * 0.038),
            margin: EdgeInsets.all(Get.width * 0.035),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Get.height * 0.0174),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(96, 96, 96, 0.2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      review.user.name.toString(),
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: Get.height * 0.023),
                    ),
                    const Spacer(),
                    Text(
                      DateFormat('dd/MM/yyyy').format(review.time ?? DateTime.now()),
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: Get.height * 0.018),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                buildRatingStar(
                  review.numberStart!.toDouble(),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Container(
                  height: Get.height * 0.104,
                  width: Get.width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (review.imagePath ?? []).length,
                      itemBuilder: (BuildContext context, int itemIndex) {
                        return Container(
                          height: Get.height * 0.087,
                          width: Get.height * 0.087,
                          margin: EdgeInsets.all(Get.height * 0.009),
                          decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(review.imagePath?[itemIndex] ?? ""), fit: BoxFit.cover)),
                        );
                      }),
                ),
                Expanded(
                  child: Text(
                    review.content.toString(),
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: Get.height * 0.025),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: Get.width * 0.05, bottom: Get.height * 0.28),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                review.user.avatarPath.toString(),
              ),
            ),
          ),
        ],
      ),
      if (review.reply != null)
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(height: Get.height * 0.06, width: Get.height * 0.06, child: Image.asset(icon_admin)),
              SizedBox(
                width: Get.height * 0.0035,
              ),
              Expanded(
                child: Container(
                    width: Get.height * 0.41,
                    padding: EdgeInsets.all(Get.width * 0.038),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 252, 232, 196),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(96, 96, 96, 0.2),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Text(review.reply.toString(), maxLines: 5)),
              ),
            ],
          ),
        ),
    ],
  );
}

Widget buildRatingStar(double starValue) {
  Color color = starValue < 2 ? Colors.red : Colors.yellow;
  var starIconsMap = [
    1,
    2,
    3,
    4,
    5
  ].map((e) {
    if (starValue >= e) {
      return Icon(
        Icons.star_rate,
        color: color,
      );
    } else if (starValue < e && starValue > e - 1) {
      return const Icon(
        Icons.star_half,
        color: Colors.yellow,
      );
    } else {
      return Icon(Icons.star_border, color: color);
    }
  }).toList();

  return Row(children: starIconsMap);
}
