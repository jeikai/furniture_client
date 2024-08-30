import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/write_review/controller/write_review_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class WriteReviewPage extends GetView<WriteReviewController> {
  const WriteReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WriteReviewController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: _buildBody(),
            ));
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      title: Padding(
        padding: EdgeInsets.only(left: Get.width / 4.4),
        child: Text(
          'Write a Review',
          style: TextStyle(
              fontFamily: jose_fin_sans,
              fontWeight: FontWeight.w800,
              fontSize: Get.width * 0.045,
              color: textBlackColor),
        ),
      ),
      leading: InkWell(
        onTap: () {
          Get.back(result: "Load page");
        },
        child: const Icon(
          Icons.arrow_back_ios,
          color: textBlackColor,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: [
          information(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  controller.status == "Write"
                      ? _ratingBar()
                      : _showRatingBar(),
                  controller.status == "Write"
                      ? pickImage()
                      : showImageFirebase(),
                  if (controller.status == "Write") showImage(),
                  writeReview(),
                  sendButton()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBar() {
    return RatingBar.builder(
      initialRating: controller.ratingNumber.toDouble(),
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 40.0,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        controller.ratingNumber = rating.toInt();
        controller.update();
      },
      updateOnDrag: true,
    );
  }

  Row _showRatingBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: List.generate(
            controller.ratingNumber,
            (index) => const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(
                Icons.star,
                color: Colors.amber,
                size: 40,
              ),
            ),
          ),
        ),
        Row(
          children: List.generate(
            5 - controller.ratingNumber,
            (index) => Padding(
              padding: const EdgeInsets.all(4),
              child: Icon(
                Icons.star,
                color: Colors.amber.withAlpha(50),
                size: 40,
              ),
            ),
          ),
        )
      ],
    );
  }

  Container information() {
    return Container(
      width: Get.width,
      height: 200,
      decoration: const BoxDecoration(
        color: WHITE,
        boxShadow: [
          BoxShadow(
            color: ColorShadow,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 20, top: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1.2),
                image: DecorationImage(
                  image: NetworkImage(
                    controller.review.product.imagePath != null &&
                        controller.review.product.imagePath!.isNotEmpty
                        ? controller.review.product.imagePath![0]
                        : 'https://scontent.fhan19-1.fna.fbcdn.net/v/t39.30808-6/457520415_3653543601624471_7425025362526940664_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=aa7b47&_nc_eui2=AeEWVi3AS8YACcdtraYC-6hDmEIlkDzus9GYQiWQPO6z0fjXWxwoXqSzUez6pa6nef9ypGmPraV5ELkU_GZomoXS&_nc_ohc=e39af-a43dMQ7kNvgHHMLje&_nc_ht=scontent.fhan19-1.fna&oh=00_AYBE9ALHbtqvIzJJ176Hs2Rojcw4V9ug5dsNC2xOQY4Gzg&oe=66D76945', // Hình ảnh mặc định
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: Get.width - 180,
                  child: Text(
                    controller.review.product.name.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontFamily: jose_fin_sans,
                        fontWeight: FontWeight.w800,
                        fontSize: Get.width * 0.05,
                        color: textBlackColor),
                  ),
                ),
                SizedBox(
                  width: Get.width - 180,
                  child: Text(
                    controller.review.product.description.toString(),
                    maxLines: 9,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Get.width * 0.035,
                        color: textGrey2Color),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container pickImage() {
    return Container(
      width: Get.width,
      height: 150,
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Photo',
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w800,
                fontSize: Get.width * 0.05,
                color: textBlackColor),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 80,
            height: 80,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              dashPattern: const [10, 10],
              color: Colors.grey,
              strokeWidth: 2,
              child: SizedBox(
                width: 100,
                height: 100,
                child: InkWell(
                  onTap: () {
                    controller.selectedImage();
                  },
                  child: const Icon(
                    Icons.add_photo_alternate,
                    size: 40,
                    color: buttonColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container showImageFirebase() {
    return Container(
      width: Get.width,
      height: 150,
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Photo: ',
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w800,
                fontSize: Get.width * 0.05,
                color: textBlackColor),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
              child: Container(
            width: Get.width,
            height: (controller.listImagePath.length / 4).ceil() * 85,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.listImagePath.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return Image.network(controller.listImagePath[index],
                    height: 85, width: 85, fit: BoxFit.cover);
              },
            ),
          ))
        ],
      ),
    );
  }

  SingleChildScrollView showImage() {
    return SingleChildScrollView(
        child: Container(
      width: Get.width,
      height: (controller.listImagePath.length / 4).ceil() * 85,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listImagePath.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return _buildImage(index);
        },
      ),
    ));
  }

  Widget _buildImage(int index) {
    return Stack(
      children: [
        Image.file(File(controller.listImagePath[index]),
            height: 85, width: 85, fit: BoxFit.cover),
        Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: WHITE,
                  ),
                  child: const Icon(
                    Icons.clear,
                    size: 20,
                  )),
              onTap: () {
                controller.deleteImage(index);
              },
            ))
      ],
    );
  }

  Container pickVideo() {
    return Container(
      width: Get.width,
      height: 150,
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Video',
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w800,
                fontSize: Get.width * 0.05,
                color: textBlackColor),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 80,
            height: 80,
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              dashPattern: const [10, 10],
              color: Colors.grey,
              strokeWidth: 2,
              child: SizedBox(
                width: 100,
                height: 100,
                child: InkWell(
                  onTap: () {
                    controller.selectedVideo();
                  },
                  child: const Icon(
                    Icons.ondemand_video,
                    size: 40,
                    color: buttonColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView showVideo() {
    return SingleChildScrollView(
        child: Container(
      width: Get.width,
      height: (controller.listVideoPath.length / 4).ceil() * 85,
      margin: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listVideoPath.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (BuildContext context, int index) {
          return _buildVideo(index);
        },
      ),
    ));
  }

  Widget _buildVideo(int index) {
    return Stack(
      children: [
        Image.file(File(controller.listVideoPath[index]),
            height: 85, width: 85, fit: BoxFit.cover),
        Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: WHITE,
                  ),
                  child: const Icon(
                    Icons.clear,
                    size: 20,
                  )),
              onTap: () {
                controller.deleteImage(index);
              },
            ))
      ],
    );
  }

  Container writeReview() {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            write_review,
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w800,
                fontSize: Get.width * 0.05,
                color: textBlackColor),
          ),
          (controller.status == "Write")
              ? Container(
                  margin: const EdgeInsets.only(top: 20, right: 20),
                  width: Get.width,
                  height: 190,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: WHITE,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: ColorShadow,
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: controller.reviewController,
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.justify,
                    maxLines: null,
                    cursorColor: textBlackColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: hint_writeReview,
                      hintStyle: TextStyle(
                        fontFamily: jose_fin_sans,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                        color: textGrey3Color,
                      ),
                    ),
                  ))
              : Text(
                  controller.reviewController.text,
                  style: TextStyle(
                    fontFamily: jose_fin_sans,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w400,
                    color: textGrey3Color,
                  ),
                ),
        ],
      ),
    );
  }

  InkWell sendButton() {
    return InkWell(
      onTap: () {
        if (controller.loadSubmit == false &&
            controller.review.numberStart == null) {
          controller.submit();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: Get.width,
        decoration: BoxDecoration(
            color: controller.status == "Write" ? buttonColor : textGrey5Color,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: ColorShadow,
                blurRadius: 10,
                spreadRadius: 4,
              )
            ]),
        child: Text(
          controller.loadSubmit
              ? 'Loading ...'
              : (controller.review.numberStart == null
                  ? 'Submmit Review'
                  : 'Review successfuly'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Get.width * 0.051,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
