import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/guarantee.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/form_guarantee/controller/form_guarantee_controller.dart';
import 'package:get/get.dart';

class FormGuaranteePage extends GetView<FormGuaranteeController> {
  const FormGuaranteePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormGuaranteeController>(
        builder: (value) => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: backgroundColor,
              appBar: appBar(),
              body: buildBody(),
            ));
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          }),
      backgroundColor: backgroundColor,
      title: Text(
        "Form Guarantee",
        style: TextStyle(
            fontSize: 20,
            fontFamily: jose_fin_sans,
            color: Colors.black,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget buildBody() {
    return Container(
      color: backgroundColor,
      width: Get.width,
      height: Get.height,
      margin: const EdgeInsets.only(top: 10, bottom: 15),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoProducts(controller.guarantees),
            const SizedBox(height: 20),
            textFieldCustom('Description of warranty claim',
                controller.errorText, 'Enter the error you are getting'),
            selectedImage(),
            showImage(),
            SizedBox(height: Get.height * 0.1),
            sendButton(),
          ]),
    );
  }

  Container infoProducts(Guarantee item) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Warranty product information",
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Container(
            width: Get.width,
            margin: const EdgeInsets.only(top: 10),
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
                  width: Get.width - 155,
                  margin: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    item.orderID.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: nunito_sans,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, top: 5, right: 20),
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(item.product.imagePath![0]),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width - 155,
                          margin: const EdgeInsets.only(top: 5),
                          child: Text(
                            item.product.name.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: nunito_sans,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            '\$${item.product.price}',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: nunito_sans,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          width: Get.width - 155,
                          child: Text(
                            'Size: ${item.product.width} x ${item.product.height} x ${item.product.length}',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: nunito_sans,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column selectedImage() {
    return Column(
      children: [
        Text(
          'Image',
          style: TextStyle(fontFamily: jose_fin_sans, fontSize: 18),
        ),
        const SizedBox(height: 20),
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

  Widget textFieldCustom(
      String title, TextEditingController content, String hintText,
      {IconButton? iconButton, TextInputType? inputType}) {
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget sendButton() {
    return InkWell(
      onTap: () {
        if (controller.loadSubmit == false) {
          controller.submit();
        }
      },
      child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: Get.width,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                BoxShadow(
                  color: ColorShadow,
                  blurRadius: 10,
                  spreadRadius: 4,
                )
              ]),
          child: Text(
              (controller.loadSubmit == true) ? "Loading...." : sendRequest,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Get.width * 0.051,
                  fontWeight: FontWeight.w600,
                  color: Colors.white))),
    );
  }
}
