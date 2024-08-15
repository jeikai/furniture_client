import 'package:furniture_app/data/models/Order.dart';
import 'package:furniture_app/data/models/notification.dart';
import 'package:furniture_app/data/repository/notification_repository.dart';
import 'package:furniture_app/data/repository/order_repository.dart';
import 'package:furniture_app/screen/detail_order/view/detail_order_page.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  List<MyNotiInformation> notifications = [];
  MyOrder? orders;
  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    notifications = await NotificationRepository().getNotificationProducts();
    update();
  }

  Future<void> loadOrder(String id) async {
    orders = await OrderRepository().getOrderWithID(id);
    print(orders);
    if (orders != null) {
      Get.to(const DetailOrderPage(), arguments: {'order': orders});
    } else {
      Get.snackbar("Error", "Not Found Order");
    }

    update();
  }
}
