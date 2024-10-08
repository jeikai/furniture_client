import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/category.dart';
import 'package:get/get.dart';

import '../../../data/repository/category_repository.dart';

class FiltersController extends GetxController {
  List<MyCategory> typeCategory = [];
  List<int> checkTypeCategory = [];
  List<Color> colorContents = [];
  List<Color> pickColored = [];

  Rx<double> range = 0.0.obs;

  int currentColor = 0;
  String categorite_path = "all";

  @override
  void onInit() {
    super.onInit();

    loadCategory();
  }

  Future<void> loadCategory() async {
    typeCategory = await CategoryRepository().getCategories();

    // Ensure the list is not empty before removing "All"
    if (typeCategory.isNotEmpty) {
      for (int i = 0; i < typeCategory.length; i++) {
        if (typeCategory[i].name == "All") {
          typeCategory.removeAt(i);
          break;
        }
      }
    }

    // Initialize checkTypeCategory after ensuring the list is populated
    checkTypeCategory = List.filled(typeCategory.length, 0);
    update();
  }

  void setRange(double range) {
    this.range.value = range;
  }

  void onSeleted(int index) {
    checkTypeCategory[index] = 1 - checkTypeCategory[index];
    update();
  }

  void onSelectedColor(int index) {
    currentColor = index;
    update();
  }

  List<Color> fromMaterialColor(List<Color> color) {
    List<Color> re = [];
    color.forEach((element) {
      Color c = Color.fromARGB(
          element.alpha, element.red, element.green, element.blue);
      re.add(c);
    });
    return re;
  }

  void changeColor(List<Color> color) {
    pickColored = fromMaterialColor(color);
    update();
  }

  List<String> getPath() {
    List<String> re = [];

    // Check if typeCategory is not empty
    if (typeCategory.isNotEmpty) {
      for (int i = 0; i < typeCategory.length; i++) {
        if (checkTypeCategory[i] == 1) {
          re.add(typeCategory[i].path.toString());
        }
      }
    }

    return re;
  }

  void clickApply() {
    // Prevent applying filters if there are no categories loaded
    if (typeCategory.isEmpty) {
      Get.snackbar('Error', 'No categories available to apply filters.');
      return;
    }

    Get.back(result: {
      'path': getPath(),
      'price': range.value,
      'color': pickColored,
    });

    pickColored = [];
  }
}
