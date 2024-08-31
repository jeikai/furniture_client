import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/data/models/Area.dart';
import 'package:furniture_app/data/repository/address_repository.dart';
import 'package:furniture_app/data/repository/area_repository.dart';
import 'package:furniture_app/data/repository/user_repository.dart';
import 'package:get/get.dart';

class AddShippingAddressController extends GetxController {
  TextEditingController addressText = TextEditingController();
  TextEditingController nameText = TextEditingController();
  TextEditingController phoneNumberText = TextEditingController();

  Area? dropdownValueProvince;
  Area? dropdownValueDistrict;
  Area? dropdownValueWard;

  List<Area> provinces = [];
  List<Area> districts = [];
  List<Area> wards = [];

  @override
  void onInit() {
    super.onInit();
    loadProvince();
  }

  Future<void> loadProvince() async {
    provinces = await AreaRepository().getProvinces();
    update();
  }

  Future<void> onSelectDropdownValueProvince(Area? value) async {
    if (value == null) return;
    dropdownValueProvince = value;
    dropdownValueDistrict = null;
    districts = await AreaRepository().getDistricts(value.code);
    dropdownValueWard = null;
    wards = [];
    update();
  }

  Future<void> onSelectDropdownValueDistrict(Area? value) async {
    if (value == null) return;
    dropdownValueDistrict = value;
    dropdownValueWard = null;
    wards = await AreaRepository().getWards(value.code);
    update();
  }

  void onSelectDropdownValueWard(Area? value) {
    if (value == null) return;
    dropdownValueWard = value;
    update();
  }

  Future<void> clickSaveAddress() async {
    int checkError = 0;
    if (nameText.text.toString() == "") {
      print("Name empty");
      checkError++;
    }
    if (addressText.text.toString() == "") {
      print("Address empty");
      checkError++;
    }
    if (phoneNumberText.text.toString() == "") {
      print("Phone number empty");
      checkError++;
    }
    // if (dropdownValueProvince == null) {
    //   print("Province empty");
    //   checkError++;
    // }
    // if (dropdownValueDistrict == null) {
    //   print("District empty");
    //   checkError++;
    // }
    // if (dropdownValueWard == null) {
    //   print("Ward empty");
    //   checkError++;
    // }
    if (checkError == 0) {
      const String defaultProvinceCode = '79'; // Ho Chi Minh City
      const String defaultDistrictCode = '001'; // A specific district in Ho Chi Minh City
      const String defaultWardCode = '00001'; // A specific ward in that district

      const String defaultProvinceName = 'Ho Chi Minh City';
      const String defaultDistrictName = 'District 1';
      const String defaultWardName = 'Ward Ben Nghe';

      Map<String, dynamic> data = {
        'receiver': nameText.text,
        'phone_number': phoneNumberText.text,
        'address': addressText.text,
        'province_code': dropdownValueProvince?.code ?? defaultProvinceCode,
        'district_code': dropdownValueDistrict?.code ?? defaultDistrictCode,
        'ward_code': dropdownValueWard?.code ?? defaultWardCode,
        'full_address': "${addressText.text}, ${dropdownValueWard?.nameWithType ?? defaultWardName}, ${dropdownValueDistrict?.nameWithType ?? defaultDistrictName}, ${dropdownValueProvince?.nameWithType ?? defaultProvinceName}",
      };

      await AddressRepository().addAdress(data);
      Get.back();
    }
  }
}
