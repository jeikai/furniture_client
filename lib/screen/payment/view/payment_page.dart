import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/screen/add_payment/view/add_payment_page.dart';
import 'package:furniture_app/screen/payment/controller/payment_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:date_format/date_format.dart';
import 'package:furniture_app/data/models/card.dart' as MyCard;
import 'package:intl/intl.dart';

class PaymentPage extends GetView<PaymentController> {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(),
              floatingActionButton: addButton(),
            ));
  }

  Widget buildBody() {
    return Container(
        width: Get.width,
        height: Get.height,
        padding: EdgeInsets.only(top: 20),
        child: Column(children: [
          _buildPaymentCash(),
          listCard(),
        ]));
  }

  SizedBox listCard() {
    return SizedBox(
      height: Get.height - 190,
      width: Get.width,
      child: ListView.builder(
        itemCount: controller.cards.length,
        itemBuilder: (context, index) => _buildItemCard(index),
      ),
    );
  }

  Column _buildPaymentCash() {
    return Column(children: [
      selectCard(-1),
      SizedBox(height: Get.height * 0.02),
    ]);
  }

  Column _buildItemCard(int index) {
    return Column(
      children: [
        Slidable(
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (context) => controller.onRemove(index),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Column(children: [
            CreditCard(
              card: controller.cards[index],
              colorBG: Colors.black,
              colorSP: Color.fromARGB(255, 88, 88, 88),
              icon: icon_masterC,
            ),
          ]),
        ),
        selectCard(index),
        SizedBox(height: Get.height * 0.02),
      ],
    );
  }

  Widget selectCard(int index) {
    return Row(children: [
      Theme(
          data: ThemeData(unselectedWidgetColor: bgRadio),
          child: Radio<int>(
            value: index,
            groupValue: controller.isSelectCard,
            onChanged: (int? value) {
              controller.onSelected(value);
            },
          )),
      Text(
          index == -1
              ? "Use as the payment in cash"
              : "Use as the payment method default",
          style: TextStyle(
            fontFamily: 'JosefinSans',
            fontSize: Get.width * 0.045,
            fontWeight: FontWeight.w400,
            color: textBlackColor,
          )),
    ]);
  }

  AppBar appBarCustom() {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: InkWell(
        onTap: () => Get.back(),
        child: SizedBox(
            height: Get.height * 0.01,
            width: Get.width * 0.01,
            child: SvgPicture.asset(icon_back, fit: BoxFit.scaleDown)),
      ),
      title: Text(
        payment_method,
        style: TextStyle(
            fontFamily: jose_fin_sans,
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.black),
      ),
      actions: [
        InkWell(
          onTap: () {
            controller.saveData();
          },
          child: const Icon(
            Icons.save,
            color: textBlackColor,
          ),
        )
      ],
    );
  }

  Widget addButton() {
    return InkWell(
        onTap: () {
          Get.to(() => AddPaymentPage())
              ?.whenComplete(() => controller.loadData());
        },
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            width: 47,
            height: 47,
            decoration: const BoxDecoration(
                color: bgbuttonAdd,
                shape: BoxShape.circle,
                boxShadow: [
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

class CreditCard extends StatelessWidget {
  MyCard.Card card;
  Color colorBG;
  Color colorSP;
  String? icon;

  CreditCard({
    Key? key,
    required this.card,
    required this.colorBG,
    required this.colorSP,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.25,
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.3, 2),
          colors: <Color>[
            colorBG,
            colorSP,
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 7,
            blurRadius: 10,
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 29,
            top: 20,
            child: SvgPicture.asset(icon.toString(), fit: BoxFit.scaleDown),
          ),
          Positioned(
            left: 29,
            top: 65,
            child: Text(
              "**** **** **** ${card.numberCard.substring(12, 16)}",
              style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 3),
            ),
          ),
          Positioned(
            left: 29,
            bottom: 45,
            child: Text(
              card_holder_name,
              style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.white),
            ),
          ),
          Positioned(
              left: 29,
              bottom: 21,
              child: Text(
                card.cardHolderName.toUpperCase(),
                style: TextStyle(
                    fontFamily: jose_fin_sans,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white),
              )),
          Positioned(
            left: 230,
            bottom: 45,
            child: Text(
              expiry_date,
              style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.white),
            ),
          ),
          Positioned(
              left: 230,
              bottom: 21,
              child: Text(
                DateFormat('MM/yy').format(card.EXD),
                style: TextStyle(
                    fontFamily: jose_fin_sans,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.white),
              )),
        ],
      ),
    );
  }
}
