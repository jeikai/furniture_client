import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:furniture_app/data/models/Address.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/images.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/add_shipping_address/view/add_shipping_address_page.dart';
import 'package:furniture_app/screen/shipping_address/controller/shipping_address_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ShippingAddressPage extends GetView<ShippingAddressController> {
  const ShippingAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShippingAddressController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: buildAppBar(),
              body: buildBody(),
            ));
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: backgroundColor,
      title: Padding(
        padding: EdgeInsets.only(left: Get.width / 6),
        child: Text(
          shipping_address,
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

  Widget buildBody() {
    return Container(
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          children: [
            controller.load
                ? Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.black,
                    size: 30,
                  ))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.address.length,
                    itemBuilder: (context, index) {
                      return buildContent(controller.address[index], index);
                    }),
            Positioned(bottom: 10, right: 16, child: addButton())
          ],
        ));
  }

  Widget addButton() {
    return InkWell(
        onTap: () {
          Get.to(const AddShippingAddressPage())
              ?.whenComplete(() => controller.loadData());
        },
        child: Container(
            height: 47,
            width: 47,
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: addButtonColor,
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

  Widget buildContent(Address address, int index) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              controller.onRemove(index);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Column(children: [
        Row(children: [
          Theme(
              data: ThemeData(unselectedWidgetColor: bgRadio),
              child: Radio<int>(
                value: index,
                groupValue: controller.selected,
                onChanged: (int? value) {
                  controller.onSelected(value);
                },
              )),
          Text(radio,
              style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: Get.width * 0.045,
                  fontWeight: FontWeight.w400,
                  color: textBlackColor)),
        ]),
        Container(
          width: Get.width - Get.height * 0.05,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(1, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10.0, horizontal: Get.width * 0.04),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Text(
                  "${address.receiver} (${address.phoneNumber})",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: Get.width * 0.039,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.05),
                  child: SvgPicture.asset(
                    ic_edit_address,
                    width: 18.0,
                    height: 18.0,
                  ),
                ),
              ]),
              const Divider(),
              Text(
                address.fullAddress,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.width * 0.039,
                    color: textGrey),
              ),
            ]),
          ),
        ),
        SizedBox(
          height: Get.height * 0.01,
        )
      ]),
    );
  }
}
