import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/request_products/controller/request_products_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RequestProduct extends GetView<RequestProductsController> {
  const RequestProduct({super.key});

  @override
  Widget build(BuildContext? context) {
    return GetBuilder<RequestProductsController>(
        builder: (value) => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: backgroundColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: backgroundColor,
                title: Padding(
                  padding: EdgeInsets.only(left: Get.width / 6),
                  child: Text(
                    request,
                    style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.w800,
                        fontSize: Get.width * 0.039,
                        color: textBlackColor),
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
              ),
              body: Container(
                color: backgroundColor,
                child: buildBody(),
              ),
            ));
  }

  Widget buildBody() {
    return Container(
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textFieldCustom(
                  request_name, controller.nameText, "Enter user name"),
              const SizedBox(height: 20),
              textFieldCustom(
                  request_address, controller.addressText, "Enter address"),
              const SizedBox(height: 20),
              textFieldCustom(
                  request_phone, controller.phoneText, "Enter phone of user",
                  inputType: TextInputType.phone, maxlength: 10),
              textFieldCustom(request_note, controller.noteText, note_input,
                  maxlength: 1000, inputType: TextInputType.multiline),
              textFieldCustom(request_price, controller.priceText,
                  "Enter your desired price",
                  inputType: TextInputType.number),
              selectedImage(),
              showImage(),
              buildButton(),
              SizedBox(height: Get.height * 0.03),
            ],
          ),
        ));
  }

  Column selectedImage() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Text(
            'Image',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: gelasio,
              fontSize: Get.width * 0.045,
              fontWeight: FontWeight.w400,
              color: textBlackColor,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: 80,
          height: 80,
          margin: const EdgeInsets.only(left: 20, bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: textBlackColor),
            borderRadius: BorderRadius.circular(20),
          ),
          child: InkWell(
            onTap: () {
              controller.selectedImage();
            },
            child: const Icon(
              Icons.camera_alt,
              size: 40,
              color: buttonColor,
            ),
          ),
        ),
      ],
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
            return _buildImageFile(index);
          },
        ),
      ),
    );
  }

  Widget _buildImageFile(int index) {
    return Stack(
      children: [
        Image.file(File(controller.listImagePath[index]),
            height: 100, width: 100, fit: BoxFit.cover),
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

  Widget textFieldCustom(
      String title, TextEditingController content, String hintText,
      {IconButton? iconButton,
      TextInputType? inputType,
      int? maxlength,
      String? validation}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title.toString(),
            style: TextStyle(
              fontFamily: jose_fin_sans,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
          TextField(
            controller: content,
            keyboardType: inputType,
            style: TextStyle(
              fontFamily: jose_fin_sans,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontSize: 20,
            ),
            cursorColor: textBlackColor,
            decoration: InputDecoration(
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: buttonColor),
                ),
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 20,
                ),
                suffixIcon: iconButton),
          ),
        ],
      ),
    );
  }

  Widget buildButton() {
    return Container(
      margin: const EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
      child: Row(children: [
        InkWell(
          child: Container(
            width: Get.width * 0.41,
            height: Get.height * 0.05,
            decoration: BoxDecoration(
                border: Border.all(color: buttonColor), color: backgroundColor),
            child: Center(
              child: Text(
                btn_cancel.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: gelasio,
                  fontSize: Get.width * 0.035,
                ),
              ),
            ),
          ),
          onTap: () {
            Get.back();
          },
        ),
        const SizedBox(width: 20),
        InkWell(
          child: Container(
            width: Get.width * 0.41,
            height: Get.height * 0.05,
            decoration: BoxDecoration(
                border: Border.all(color: buttonColor), color: buttonColor),
            child: Center(
              child: InkWell(
                onTap: () {
                  controller.clickSubmitButton();
                },
                child: Container(
                  width: Get.width * 0.5,
                  height: Get.height * 0.05,
                  padding: EdgeInsets.all(Get.height * 0.015),
                  child: controller.submitLoadButton
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "LOADING  ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'JosefinSans',
                              ),
                            ),
                            LoadingAnimationWidget.waveDots(
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        )
                      : Text(
                          btn_submit.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'JosefinSans',
                          ),
                        ),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
