import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/filters/controller/filters_controller.dart';
import 'package:get/get.dart';

class FiltersPage extends GetView<FiltersController> {
  String category;
  FiltersPage({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    controller.categorite_path = category;
    return GetBuilder<FiltersController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              body: buildBody(context),
            ));
  }

  Container buildBody(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.all(Get.height * 0.012),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 50,
          height: 4,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(50)),
        ),
        (category == 'all') ? typeFilter() : Container(),
        SizedBox(height: Get.height * 0.02),
        priceFilter(),
        SizedBox(height: Get.height * 0.02),
        colorFilter(),
        SizedBox(height: Get.height * 0.02),
        buttonApply(),
        SizedBox(height: Get.height * 0.02),
      ]),
    );
  }

  Widget typeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          type,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Get.height * 0.024,
              color: Colors.black),
        ),
        typeCustom(),
      ],
    );
  }

  Widget typeCustom() {
    List<Widget> items = [];
    for (int i = 0; i < controller.typeCategory.length; i++) {
      items.add(typeWidget(i));
      items.add(SizedBox(
        width: Get.height * 0.019,
      ));
    }
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: Get.height * 0.024),
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.018),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
      ),
    );
  }

  Widget typeWidget(int index) {
    return InkWell(
      onTap: () {
        controller.onSeleted(index);
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(Get.height * 0.012),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                  style: controller.checkTypeCategory[index] == 1
                      ? BorderStyle.solid
                      : BorderStyle.none),
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              color: controller.checkTypeCategory[index] == 1
                  ? buttonColor
                  : TextFieldColor,
            ),
            child: Text(
              controller.typeCategory[index].name.toString(),
              style: TextStyle(
                fontSize: Get.height * 0.018,
                color: controller.checkTypeCategory[index] == 1
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget priceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          priceRa,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Get.height * 0.024,
              color: Colors.black),
        ),
        SizedBox(height: Get.height * 0.024),
        Obx(
          () => Slider(
            value: controller.range.value,
            min: 0.0,
            max: 5000.0,
            divisions: 255,
            activeColor: buttonColor,
            inactiveColor: Colors.grey,
            thumbColor: Colors.orange,
            label: controller.range.round().toString(),
            onChanged: (double value) {
              controller.setRange(value);
            },
          ),
        )
      ],
    );
  }

  Widget colorFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Text(
              color,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Get.height * 0.024,
                  color: Colors.black),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                chooseColor(Get.context);
              },
              icon: const Icon(
                Icons.palette,
                size: 25,
                color: buttonColor,
              ),
            )
          ],
        ),
        colorCustom(),
      ],
    );
  }

  Widget colorCustom() {
    List<Widget> items = [];
    for (int i = 0; i < controller.pickColored.length; i++) {
      items.add(colorWidget(i));
      items.add(SizedBox(
        width: Get.height * 0.0189,
      ));
    }
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: Get.height * 0.024),
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.018),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: items,
        ),
      ),
    );
  }

  Widget colorWidget(int index) {
    Color title = controller.pickColored[index];
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: title.withAlpha(150),
          child: CircleAvatar(radius: 15, backgroundColor: title),
        ),
      ],
    );
  }

  Widget buttonApply() {
    return Container(
      width: Get.height * 0.1,
      height: Get.height * 0.05,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey)],
      ),
      child: InkWell(
        child: Text(
          apply,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: Get.height * 0.024),
        ),
        onTap: () {
          controller.clickApply();
        },
      ),
    );
  }

  List<Color> colorController = [];

  void chooseColor(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Colors'),
            content: SingleChildScrollView(
              child: MultipleChoiceBlockPicker(
                pickerColors: colorController,
                onColorsChanged: (List<Color> colors) {
                  controller.changeColor(colors);
                  colorController = colors;
                },
              ),
            ),
          );
        });
  }
}
