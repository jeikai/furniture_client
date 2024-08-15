import 'package:flutter/material.dart';
import 'package:furniture_app/data/repository/guarantee_doing_repository.dart';
import 'package:furniture_app/data/repository/guarantee_repository.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';



import '../../../data/models/guarantee.dart';
import '../../../data/models/guarantee_doing.dart';

class ListGuaranteeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedTab = 0;
  List<Tab> myTabs = [
    Tab(text: tab1),
    Tab(text: tab2),
    Tab(text: tab3),
  ];
  List<Guarantee> totalGuarantees = [];
  List<GuaranteeDoing> totalGuaranteesDoing = [];
  List<Guarantee> guarantees = [];
  List<GuaranteeDoing> guaranteesDoing = [];
  bool load = false;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    _loadGuarantees();
  }

  Future<void> _loadGuarantees() async {
    load = true;
    totalGuarantees = await GuaranteeRepository().getGuarantees();
    totalGuaranteesDoing =
        await GuaranteeDoingRepository().getGuaranteesDoing();
    onChangePage(selectedTab);
    update();
  }

  void onChangePage(int index) {
    selectedTab = index;
    guarantees = [];
    if (index == 0) {
      totalGuarantees.forEach((element) {
        DateTime t = Jiffy.parseFromDateTime(element.time).add(months: 3).dateTime;
        if (t.isAfter(DateTime.now())) guarantees.add(element);
      });
    }
    if (index == 2) {
      totalGuarantees.forEach((element) {
        DateTime t = Jiffy.parseFromDateTime(element.time).add(months: 3).dateTime;
        if (t.isBefore(DateTime.now())) guarantees.add(element);
      });
    }
    update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
