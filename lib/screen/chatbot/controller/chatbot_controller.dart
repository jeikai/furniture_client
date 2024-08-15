import 'package:flutter/cupertino.dart';
import 'package:furniture_app/data/models/Order.dart';
import 'package:furniture_app/data/models/cart.dart';
import 'package:furniture_app/data/models/chatbot.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/models/user_profile.dart';
import 'package:furniture_app/data/repository/chatbot_repository.dart';
import 'package:furniture_app/data/repository/order_repository.dart';
import 'package:furniture_app/data/repository/product_repository.dart';
import 'package:furniture_app/data/repository/user_repository.dart';
import 'package:furniture_app/screen/chatbot/view/changeEmail.dart';
import 'package:furniture_app/screen/chatbot/view/detailProductStatus_page.dart';
import 'package:furniture_app/screen/chatbot/view/error_received.dart';
import 'package:furniture_app/screen/chatbot/view/orderStatus_page.dart';
import 'package:furniture_app/screen/chatbot/view/order_error.dart';
import 'package:furniture_app/screen/chatbot/view/policy_page.dart';
import 'package:furniture_app/screen/chatbot/view/refund_page.dart';
import 'package:furniture_app/screen/chatbot/view/show_products_page.dart';
import 'package:furniture_app/screen/chatbot/view/status_complete.dart';
import 'package:furniture_app/screen/chatbot/view/status_delivering.dart';
import 'package:furniture_app/screen/chatbot/view/status_ordered.dart';
import 'package:furniture_app/screen/chatbot/view/status_preparing.dart';
import 'package:furniture_app/screen/chatbot/view/wrong_product.dart';
import 'package:furniture_app/screen/product_detail/view/product_detail_page.dart';
import 'package:get/get.dart';

import '../view/chatmessage.dart';

class ChatBotController extends GetxController {
  final TextEditingController textInput = TextEditingController();
  late MyOrder order;
  List<History> history = [];
  bool loadMess = false;

  @override
  void onInit() {
    super.onInit();
    loadDataTemplate();
    loadOrderStatus();
  }

  Future<void> loadDataTemplate() async {
    ChatBotMessage chatBotMessage = await ChatBotRepository().getChatBotMessage('begin');
    ChatMessage mess = ChatMessage(messageContent: chatBotMessage.content, messageButton: chatBotMessage.contenButton, messageType: 'admin');
    history.insert(0, History(chatMessage: mess));
    update();
  }

  Future<void> loadDataButtonTemplate() async {
    ChatBotMessage chatBotMessage = await ChatBotRepository().getChatBotMessage('begin');
    ChatMessage mess = ChatMessage(messageContent: [], messageButton: chatBotMessage.contenButton, messageType: 'admin');
    history.insert(0, History(chatMessage: mess));
    update();
  }

  Future<void> chooseButton(String content, String id) async {
    ChatMessage mess = ChatMessage(messageContent: [
      content
    ], messageType: 'user');
    history.insert(0, History(chatMessage: mess));
    update();
    if (id != "") {
      ChatBotMessage chatBotMessage = await ChatBotRepository().getChatBotMessage(id);
      ChatMessage mess = ChatMessage(messageContent: chatBotMessage.content, messageButton: chatBotMessage.contenButton, messageType: 'admin');
      history.insert(0, History(chatMessage: mess));
      update();
    } else {
      if (content == "Product warranty policy") {
        history.insert(
            0,
            History(widget: PolicyPage()
                // ChangeEmailPage(),
                ));

        update();
        loadDataButtonTemplate();
        return;
      }
      if (content == "Shipping process") {
        history.insert(0, History(widget: await loadOrderStatus()));
        update();
        return;
      }
      if (content == "Hot Products") {
        clickHotProduct();
        loadDataButtonTemplate();
        return;
      }
      if (content == "Return/Refund Conditions") {
        history.insert(0, History(widget: RefundPage()));
        update();
        loadDataButtonTemplate();
        return;
      }
      if (content == "I'm having trouble placing an order") {
        history.insert(0, History(widget: const OrderErrorPage()));
        update();
        return;
      }
      if (content == "My order is damaged, missing, wrong product") {
        history.insert(0, History(widget: const WrongProductPage()));
        update();
        loadDataButtonTemplate();
        return;
      }
      if (content == "I still have not received the goods") {
        history.insert(0, History(widget: const ErrorReceivedPage()));
        update();
        loadDataButtonTemplate();
        return;
      }
    }
  }

  Future<void> clickHotProduct() async {
    loadMess = true;
    update();
    List<Product> product = await ProductRepository().getHotProducts();
    if (product.length > 0) {
      history.insert(
          0,
          History(
              widget: ShowProductPage(
            products: product,
          )));
    }
    loadMess = false;
    update();
  }

  List<MyOrder> orders = [];
  List<Cart> carts = [];
  List<Product> products = [];
  List<String> status = [];

  Future<Widget> loadOrderStatus() async {
    loadMess = true;
    update();
    orders = await OrderRepository().getOrders();
    carts = [];
    products = [];
    status = [];
    for (int i = 0; i < orders.length; i++) {
      carts.add(orders[i].carts[0]);
      products.add(await ProductRepository().getProduct(carts[i].idProduct));
      status.add(OrderRepository.statusOrderToString(orders[i]));
    }
    loadMess = false;
    return OrderStatusPage(
      orders: orders,
      carts: carts,
      products: products,
      status: status,
    );
  }

  Future<Widget> loadDetail(int index) async {
    return DetailProductStatusPage(
      carts: carts[index],
      product: products[index],
      orders: orders[index],
      status: status[index],
    );
  }

  Future<void> loadDetailOrder(int index) async {
    history.insert(
        0,
        History(
          widget: await loadDetail(index),
        ));
    update();
    switch (status[index]) {
      case 'Ordered':
        history.insert(
            0,
            History(
              widget: StatusOrderedPage(
                order: orders[index],
                status: status[index],
              ),
            ));

        break;

      case 'Delivery in progress':
        history.insert(
            0,
            History(
                widget: StatusDelivering(
              order: orders[index],
              status: status[index],
            )));
        break;

      case 'Preparing':
        history.insert(
            0,
            History(
                widget: StatusPreparingPage(
              order: orders[index],
              status: status[index],
            )));
        loadDataButtonTemplate();
        update();
        break;
      case 'Completed':
        history.insert(
            0,
            History(
              widget: StatusCompletePage(
                order: orders[index],
                status: status[index],
              ),
            ));
        ChatMessage mess = ChatMessage(messageContent: const [
          "Related questions"
        ], messageButton: const {
          "My order is damaged, missing, wrong product": '',
          "Return/Refund Conditions": '',
          "I still have not received the goods": '',
        }, messageType: 'admin');
        history.insert(0, History(chatMessage: mess));
        break;
    }
    update();
  }

  Future<void> toDetailProduct(Product product) async {
    UserProfile currenUser = await UserRepository().getUserProfile();
    await Get.to(ProductDetailPage(), arguments: {
      "product": product,
      "favorite": currenUser.checkFavories(product.id.toString()),
      "cart": currenUser.checkCart(product.id.toString()),
    });
  }
}

class History {
  Widget? widget;
  ChatMessage? chatMessage;
  History({this.widget, this.chatMessage});
}
