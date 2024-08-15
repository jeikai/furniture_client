import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/Address.dart';
import 'package:furniture_app/data/models/Discount.dart';
import 'package:furniture_app/data/models/Order.dart';
import 'package:furniture_app/data/models/cart.dart';
import 'package:furniture_app/data/models/payment.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/repository/address_repository.dart';
import 'package:furniture_app/data/repository/card_repository.dart';
import 'package:furniture_app/data/repository/cart_repository.dart';
import 'package:furniture_app/data/repository/order_repository.dart';
import 'package:furniture_app/screen/congrats/view/congrats_page.dart';
import 'package:get/get.dart';
import '../../../data/models/card.dart' as MyCard;

class CheckoutController extends GetxController {
  List<Cart> carts = [];
  List<Product> products = [];
  Address address = Address.template();
  MyCard.Card payment = MyCard.Card.template();
  double priceOrder = 0, priceDelivery = 0, priceTotal = 0, priceDiscount = 0;
  MyDiscount? discount;
  bool paymentLoadButton = false;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments['carts'] != null) {
      carts = Get.arguments['carts'];
    }
    if (Get.arguments['products'] != null) {
      products = Get.arguments['products'];
    }

    for (int i = 0; i < carts.length; i++) {
      priceOrder = priceOrder + products[i].price! * carts[i].amount;
    }
    resetShippingAddress();
    resetPayment();
  }

  double checkWeightUrban(double weight) {
    if (weight > 0 && weight <= 3) return 1.32;
    if (weight > 3 && weight <= 5) return 2;
    if (weight > 5 && weight <= 10) return 3.45;
    if (weight > 10 && weight <= 20) return 5.80;
    if (weight > 20 && weight <= 50) return 10;
    if (weight > 50 && weight <= 100) return 20;
    return (weight - 100) * 0.2 + 20;
  }

  double checkWeightSuburban(double weight) {
    if (weight > 0 && weight <= 3) return 2.09;
    if (weight > 3 && weight <= 5) return 2.51;
    if (weight > 5 && weight <= 10) return 4.73;
    if (weight > 10 && weight <= 20) return 8.99;
    if (weight > 20 && weight <= 50) return 15;
    if (weight > 50 && weight <= 100) return 30;
    return (weight - 100) * 0.5 + 30;
  }

  Future<void> resetShippingAddress() async {
    address = await AddressRepository().getAddressDefault();
    for (int i = 0; i < carts.length; i++) {
      double weight = (products[i].weight >=
              ((products[i].width /
                      100.0 *
                      products[i].length /
                      100.0 *
                      products[i].height /
                      100.0) /
                  5000))
          ? products[i].weight
          : (products[i].width /
                  100.0 *
                  products[i].length /
                  100.0 *
                  products[i].height /
                  100.0) /
              5000;
      if (address.id == 'id' && address.provinceCode == '48') {
        priceDelivery = priceDelivery + checkWeightUrban(weight);
      } else {
        priceDelivery = priceDelivery + checkWeightSuburban(weight);
      }
    }
    priceTotal = priceDelivery + priceOrder;
    update();
  }

  Future<void> clickPaymentButton() async {
    if (paymentLoadButton == false) {
      paymentLoadButton = true;
      update();
      MyOrder order = MyOrder(
        carts: carts,
        status: [
          StatusOrder(status: "Ordered", date: DateTime.now()),
          StatusOrder(status: "Preparing"),
          StatusOrder(status: "Delivery in progress"),
          StatusOrder(status: "Completed")
        ],
        address: address,
        paymentInCash: payment.id == "id",
        paymentByCard: payment.id == "id" ? null : payment,
        discountID: discount != null ? discount!.id : null,
        priceOrder: priceOrder,
        priceDelivery: priceDelivery,
        priceDiscount: priceDiscount,
        priceTotal: priceTotal,
      );
      await OrderRepository().addToOrder(order);
      await CartRepository().deleteCarts(carts);
      Get.back(result: "Reload list cart");
      Get.to(const CongratsPage());
    }
  }

  Future<void> resetPayment() async {
    try {
      payment = await CardRepository().getCardDefault();
    } catch (e) {
      payment = MyCard.Card.template();
    }

    update();
  }

  void setDiscount(MyDiscount discount) {
    this.discount = discount;
    priceDiscount = (priceOrder * discount.percent > discount.priceLimit)
        ? discount.priceLimit
        : priceOrder * discount.percent;
    priceTotal = priceDelivery + priceOrder - priceDiscount;
    update();
  }
}
