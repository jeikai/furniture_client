import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_app/data/auth/auth_service.dart';
import 'package:furniture_app/data/models/message.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/chat_product/controller/chat_product_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatProductPage extends GetView<ChatProductController> {
  ChatProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatProductController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(),
            ));
  }

  Container buildBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          bodyChat(),
          formChat(),
        ],
      ),
    );
  }

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('chatroom').doc(AuthService.userId).collection('message').orderBy('time', descending: true).snapshots();

  Widget bodyChat() {
    return Expanded(
      child: Container(
          padding: EdgeInsets.only(left: Get.height * 0.029, right: Get.height * 0.029),
          // color: Colors.red,
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print('ERROR Steam chat product: ${snapshot.hasError}');
                return Container();
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.black,
                  size: 30,
                ));
              }
              return ListView(
                reverse: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  Message message = Message.fromMap(data);
                  return _buildItem(message);
                }).toList(),
              );
            },
          )),
    );
  }

  Widget _buildItem(Message message) {
    if (message.isAdmin) {
      if (message.productId == null) {
        return _itemChat(
          chatAdmin: 1,
          message: message.content.toString(),
          time: message.time,
        );
      } else {
        return _itemProduct(
          chatAdmin: 1,
          productImage: message.productImage,
          productName: message.productName,
          productPrice: message.productPrice,
        );
      }
    } else {
      if (message.productId == null) {
        return _itemChat(
          chatAdmin: 0,
          message: message.content.toString(),
          time: message.time,
        );
      } else {
        return _itemProduct(
          chatAdmin: 0,
          productImage: message.productImage,
          productName: message.productName,
          productPrice: message.productPrice,
        );
      }
    }
  }

  Widget _itemProduct({required int chatAdmin, DateTime? time, String? productImage, String? productName, double? productPrice}) {
    return Container(
      child: Row(
        mainAxisAlignment: chatAdmin == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (chatAdmin == 0)
            const SizedBox(
              width: 50,
            ),
          Flexible(
            child: Container(
              height: 70,
              margin: EdgeInsets.only(left: Get.height * 0.011, right: Get.height * 0.011, top: Get.height * 0.023),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: chatAdmin == 0 ? buttonColor : Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  height: 50,
                  width: 100,
                  child: (productImage != null)
                      ? Image.network(
                          productImage,
                          fit: BoxFit.contain,
                        )
                      : SizedBox(),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productName.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: gelasio,
                          fontSize: 14,
                          color: textGrey2Color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "\$ ${productPrice ?? 0}",
                        style: TextStyle(
                          fontFamily: jose_fin_sans,
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ),
          ),
          if (chatAdmin == 1)
            Text(
              '$time',
              style: TextStyle(color: Colors.grey.shade400),
            )
        ],
      ),
    );
  }

  Widget _itemChat({required int chatAdmin, String message = "", DateTime? time}) {
    return Row(
      mainAxisAlignment: chatAdmin == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (chatAdmin == 0)
          const SizedBox(
            width: 50,
          ),
        Flexible(
          child: Container(
            margin: EdgeInsets.only(left: Get.height * 0.011, right: Get.height * 0.011, top: Get.height * 0.023),
            padding: EdgeInsets.all(Get.height * 0.023),
            decoration: BoxDecoration(
              color: chatAdmin == 0 ? buttonColor : Colors.white,
              borderRadius: chatAdmin == 0
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )
                  : const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
            ),
            child: Text('$message'),
          ),
        ),
        if (chatAdmin == 1)
          Text(
            '${DateFormat.jm().format(time ?? DateTime.now())}',
            style: TextStyle(color: Colors.grey.shade400),
          )
      ],
    );
  }

  Widget formChat() {
    return Positioned(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: Get.height * 0.118,
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.035, horizontal: Get.height * 0.023),
          color: backgroundColor,
          child: TextField(
            controller: controller.messageText,
            decoration: InputDecoration(
              hintText: type_mess,
              suffixIcon: InkWell(
                onTap: () {
                  controller.sendMessage();
                },
                child: Container(
                  width: Get.height * 0.059,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Get.height * 0.059), color: buttonColor),
                  padding: const EdgeInsets.all(0.006),
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: Get.height * 0.029,
                  ),
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(fontSize: Get.height * 0.014),
              contentPadding: EdgeInsets.only(top: Get.height * 0.006, bottom: Get.height * 0.006, left: Get.height * 0.023),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: buttonColor),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      leading: IconButton(
        icon: SvgPicture.asset(icon_back, fit: BoxFit.scaleDown),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(
        chat_product,
        style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w700, fontSize: 0.019, color: Colors.black),
      ),
    );
  }
}
