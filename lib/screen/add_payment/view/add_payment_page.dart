import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_app/data/models/bank.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/screen/add_payment/controller/add_payment_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

class AddPaymentPage extends GetView<AddPaymentController> {
  const AddPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPaymentController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: buildBody(),
            ));
  }

  Widget buildBody() {
    return Container(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: 20),
            creditCard(),
            SizedBox(height: Get.height * 0.05),
            InfoCardName(
              title: card_holder_name,
              content: controller.nameController,
              hintText: 'Ex: BRUNO PHAM',
              width: Get.width * 0.9,
            ),
            SizedBox(height: Get.height * 0.01),
            InfoCard(
              title: number_card,
              content: controller.numberController,
              hintText: 'Ex: **** **** **** 3456',
              maxLength: 16,
              isKeyboardNumber: true,
              width: Get.width * 0.9,
            ),
            SizedBox(height: Get.height * 0.01),
            _buildChooseBank(),
            SizedBox(height: Get.height * 0.01),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(
                    title: ccv,
                    content: controller.cvvController,
                    hintText: 'Ex: 1234',
                    maxLength: 4,
                    width: Get.width * 0.44,
                    isKeyboardNumber: true,
                  ),
                  InfoCard(
                    title: expiration_date,
                    content: controller.expiryController,
                    hintText: 'Ex: 11/28',
                    width: Get.width * 0.44,
                    isDate: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height - 650),
            addCardButton(),
          ]),
        ));
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
        add_payment_method,
        style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black),
      ),
    );
  }

  Widget creditCard() {
    return Container(
      height: Get.height * 0.25,
      width: Get.width * 0.9,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.3, 2),
          colors: <Color>[
            Colors.black,
            Color.fromARGB(255, 88, 88, 88),
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
            child: SvgPicture.asset(icon_masterC, fit: BoxFit.scaleDown),
          ),
          Positioned(
            left: 29,
            top: 65,
            child: Text(
              template_card,
              style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w600, fontSize: 20, color: Colors.white, letterSpacing: 3),
            ),
          ),
          Positioned(
            left: 29,
            bottom: 45,
            child: Text(
              card_holder_name,
              style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),
            ),
          ),
          Positioned(
              left: 29,
              bottom: 21,
              child: Text(
                'XXXXXX'.toString(),
                style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),
              )),
          Positioned(
            left: 230,
            bottom: 45,
            child: Text(
              expiry_date,
              style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),
            ),
          ),
          Positioned(
              left: 230,
              bottom: 21,
              child: Text(
                'XX/XX'.toString(),
                style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),
              )),
        ],
      ),
    );
  }

  Widget addCardButton() {
    return InkWell(
      onTap: () {
        if (controller.load == false) controller.addCart();
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: Get.width,
          decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(10), boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(96, 96, 96, 0.2),
              blurRadius: 10,
              spreadRadius: 4,
            )
          ]),
          child: Text(controller.load ? "LOADING..." : add_new_card, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white))),
    );
  }

  Widget selectedBank() {
    if (controller.banks == null || controller.banks.length == 0) {
      return Container();
    }
    if (controller.seletedBank == null) controller.seletedBank = controller.banks[0];

    return Container(
      width: Get.width - 55,
      child: DropdownButton<Bank>(
        value: controller.seletedBank,
        icon: const Icon(Icons.arrow_downward),
        onChanged: (Bank? value) {
          if (value != null) {
            controller.changedBank(value);
          }
        },
        items: controller.banks.map<DropdownMenuItem<Bank>>((Bank value) {
          return DropdownMenuItem<Bank>(
            value: value,
            child: Container(
              width: Get.width - 80,
              child: Row(
                children: [
                  Image.network(
                    value.logo,
                    width: 100,
                  ),
                  Expanded(
                      child: Text(
                    value.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  )),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChooseBank() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 10, left: 10),
      margin: const EdgeInsets.only(left: 18, right: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 187, 187, 187)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Bank",
            style: TextStyle(
              fontFamily: jose_fin_sans,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          selectedBank(),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  String? title;
  TextEditingController? content;
  String? hintText;
  double? width;
  bool isKeyboardNumber = false;
  bool isDate = false;
  int? maxLength;

  InfoCard({
    Key? key,
    this.title,
    this.content,
    this.hintText,
    this.width,
    this.isKeyboardNumber = false,
    this.isDate = false,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(top: 10, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 187, 187, 187)),
        color: Colors.white,
      ),
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
              fontSize: 14,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: TextField(
              controller: content,
              onChanged: (value) {
                content?.value = TextEditingValue(text: value.toUpperCase(), selection: content!.selection);
              },
              maxLength: maxLength,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              cursorColor: buttonColor,
              keyboardType: isKeyboardNumber ? TextInputType.number : TextInputType.text,
              inputFormatters: [
                isDate ? DateInputFormatter() : NumberTextInputFormatter(),
              ],
              decoration: InputDecoration(
                counterText: "",
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InfoCardName extends StatelessWidget {
  String? title;
  TextEditingController? content;
  String? hintText;
  double? width;
  int? maxLength;

  InfoCardName({
    Key? key,
    this.title,
    this.content,
    this.hintText,
    this.width,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.only(top: 10, left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromARGB(255, 187, 187, 187)),
        color: Colors.white,
      ),
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
              fontSize: 14,
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: TextField(
              controller: content,
              onChanged: (value) {
                content?.value = TextEditingValue(text: value.toUpperCase(), selection: content!.selection);
              },
              maxLength: maxLength,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              cursorColor: buttonColor,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
