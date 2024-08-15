import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/Area.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/add_shipping_address/controller/add_shipping_address_controller.dart';
import 'package:get/get.dart';

class AddShippingAddressPage extends GetView<AddShippingAddressController> {
  const AddShippingAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddShippingAddressController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: backgroundColor,
                title: Padding(
                  padding: EdgeInsets.only(left: Get.width / 6),
                  child: Text(
                    add_shipping_address,
                    style: TextStyle(
                        fontFamily: jose_fin_sans,
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
              body: buildBody(),
            ));
  }

  Widget buildBody() {
    return Container(
      color: backgroundColor,
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: Get.height * 0.01),
            textFieldCustom(controller.nameText, address_name, name_hintext),
            SizedBox(height: Get.height * 0.03),
            textFieldCustom(
                controller.phoneNumberText, phone_number, phonenumber_hintext,
                textInputType: TextInputType.phone, maxLength: 10),
            SizedBox(height: Get.height * 0.03),
            textFieldCustom(controller.addressText, address, address_hintext),
            SizedBox(height: Get.height * 0.03),
            _buildAddress(),
            SizedBox(height: Get.height * 0.09),
            addButton(),
          ],
        ),
      ),
    );
  }

  Widget textFieldCustom(
      TextEditingController controller, String title, String hintText,
      {TextInputType? textInputType, int? maxLength}) {
    return Container(
        padding: const EdgeInsets.only(left: 10),
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
        child: TextField(
          controller: controller,
          keyboardType: textInputType,
          maxLength: maxLength,
          cursorColor: textBlackColor,
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: TextFieldColor)),
            labelText: title,
            hintText: hintText,
            hintStyle: TextStyle(
                fontFamily: jose_fin_sans,
                fontSize: Get.width * 0.045,
                fontWeight: FontWeight.w400,
                color: textGrey3Color),
            labelStyle: TextStyle(
                fontFamily: jose_fin_sans,
                fontSize: Get.width * 0.05,
                fontWeight: FontWeight.w400,
                color: textBlackColor),
          ),
        ));
  }

  Widget textFieldCustomAddress(
      TextEditingController controller, String title, String hintText) {
    return Container(
        padding: const EdgeInsets.only(left: 10),
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
        child: TextField(
          controller: controller,
          cursorColor: textBlackColor,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: TextFieldColor)),
              labelText: title,
              hintText: hintText,
              hintStyle: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontSize: Get.width * 0.045,
                  fontWeight: FontWeight.w400,
                  color: textGrey3Color),
              labelStyle: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontSize: Get.width * 0.05,
                  fontWeight: FontWeight.w400,
                  color: textBlackColor),
              suffixIcon: Icon(
                Icons.expand_more_outlined,
                color: textBlackColor,
              )),
        ));
  }

  Widget addButton() {
    return InkWell(
      onTap: () {
        controller.clickSaveAddress();
      },
      child: Container(
          margin:
              const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 20),
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: Get.width,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: ColorShadow,
                  blurRadius: 10,
                  spreadRadius: 4,
                )
              ]),
          child: Text(button_address,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Get.width * 0.051,
                  fontWeight: FontWeight.w600,
                  color: Colors.white))),
    );
  }

  Widget _buildAddress() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(left: 10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          selectedArea(address_province, controller.provinces,
              controller.dropdownValueProvince, 'province'),
          SizedBox(height: Get.height * 0.01),
          selectedArea(address_district, controller.districts,
              controller.dropdownValueDistrict, 'district'),
          SizedBox(height: Get.height * 0.01),
          selectedArea(address_ward, controller.wards,
              controller.dropdownValueWard, 'ward'),
        ],
      ),
    );
  }

  Widget selectedArea(
      String title, List<Area> list, Area? selectedItem, String type) {
    if (list == null || list.length == 0) {
      return Container();
    }

    if (selectedItem == null) selectedItem = list[0];

    return SizedBox(
      width: Get.width,
      child: DropdownButton<Area>(
        isExpanded: true,
        value: selectedItem,
        icon: const Icon(
          Icons.expand_more,
          size: 30,
          color: textBlackColor,
        ),
        onChanged: (Area? value) {
          if (type == 'province') {
            controller.onSelectDropdownValueProvince(value);
          }
          if (type == 'district') {
            controller.onSelectDropdownValueDistrict(value);
          }
          if (type == 'ward') {
            controller.onSelectDropdownValueWard(value);
          }
        },
        items: list.map<DropdownMenuItem<Area>>((Area value) {
          return DropdownMenuItem<Area>(
            value: value,
            child: Text(value.name),
          );
        }).toList(),
      ),
    );
  }
}
