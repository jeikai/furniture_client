import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/data/models/Address.dart';
import 'package:furniture_app/data/repository/address_repository.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:get/get.dart';

class ShippingAddressController extends GetxController {
  List<Address> address = [];
  int selected = 0;
  bool load = true;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    load = true;
    update();
    String addressDefaultCode = await AddressRepository().getIdAddressDefalut();
    address = await AddressRepository().getAddress();
    for (int i = 0; i < address.length; i++) {
      if (address[i].id == addressDefaultCode) {
        selected = i;
        break;
      }
    }
    load = false;
    update();
  }

  Future<void> saveData() async {
    if (selected != null) {
      await AddressRepository().updateAddressDefalut(address[selected]);
    }
  }

  void onSelected(int? value) {
    if (value != null) {
      selected = value;
      update();
    }
  }

  Future<void> onRemove(index) async {
    String addressDefaultCode = await AddressRepository().getIdAddressDefalut();
    if (address[index].id == addressDefaultCode) {
      Fluttertoast.showToast(
        msg:
            "Your address is now the default address, please choose a different one before deleting it.",
        gravity: ToastGravity.TOP,
        textColor: WHITE,
        backgroundColor: textBlack3Color,
      );
      return;
    } else {
      await AddressRepository().deleteAddress(address[index].id);
      loadData();
    }
  }
}
