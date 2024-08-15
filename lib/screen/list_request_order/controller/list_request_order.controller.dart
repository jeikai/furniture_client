import 'package:furniture_app/data/models/request_order.dart';
import 'package:furniture_app/data/models/user_profile.dart';
import 'package:furniture_app/data/repository/request_repository.dart';
import 'package:furniture_app/data/repository/user_repository.dart';
import 'package:get/get.dart';

class ListRequestOrderController extends GetxController {
  List<String> tab = [
    "Ordered",
    "Preparing",
    "Delivery",
    "Completed",
    "Cancel"
  ];
  Rx<int> tabCurrentIndex = 0.obs;
  List<bool> check = [];
  bool all = false;
  int dem = 0;
  List<RequestOrder> totalOrder = [];
  List<RequestOrder> orders = [];
  List<UserProfile> users = [];
  bool load = true;

  @override
  void onInit() {
    super.onInit();
    loadTotalOrder();
  }

  Future<void> loadTotalOrder() async {
    totalOrder = await RequestOrderRepository().getOrders();
    onChangePage(0);
  }

  void updateCheckPoint(int index) {
    check[index] = !check[index];
    if (check[index]) {
      dem = dem + 1;
    } else {
      dem = dem - 1;
    }
    if (!check[index] && check[index] != all) {
      all = check[index];
    } else if (dem == totalOrder.length) {
      all = true;
    }

    update();
  }

  void updateCheckPointAll() {
    all = !all;
    if (all) {
      dem = totalOrder.length;
    } else {
      dem = 0;
    }
    check = List.filled(totalOrder.length, all);
    update();
  }

  Future<void> onChangePage(int index) async {
    load = true;
    update();
    tabCurrentIndex.value = index;
    orders = [];
    users = [];
    for (int i = 0; i < totalOrder.length; i++) {
      if (RequestOrderRepository.statusOrderToString(totalOrder[i]) ==
          tab[index]) {
        orders.add(totalOrder[i]);
        users.add(await UserRepository().getUserProfile());
      }
    }
    check = List.filled(orders.length, false);
    load = false;
    update();
  }
}
