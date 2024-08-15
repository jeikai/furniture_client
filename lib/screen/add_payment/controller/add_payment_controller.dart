import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/data/models/card.dart';
import 'package:furniture_app/data/repository/bank_repository.dart';
import 'package:furniture_app/data/repository/card_repository.dart';
import 'package:furniture_app/screen/chatbot/view/chatbot_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/bank.dart';

class AddPaymentController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  List<Bank> banks = [];
  Bank? seletedBank;
  bool load = false;

  @override
  void onInit() {
    super.onInit();
    loadBanks();
  }

  Future<void> loadBanks() async {
    banks = await BankRepository().getBank();
    update();
  }

  void changedBank(Bank bank) {
    seletedBank = bank;
    update();
  }

  Future<void> addCart() async {
    load = true;
    update();
    int check = 0;
    if (nameController.text == "") {
      check++;
    }
    if (numberController.text.length != 16) {
      check++;
    }
    if (cvvController.text.length != 4) {
      check++;
    }
    if (expiryController.text == "") {
      check++;
    }
    if (seletedBank == null) {
      check++;
    }
    if (check == 0) {
      Card card = Card(
        id: "",
        cardHolderName: nameController.text,
        numberCard: numberController.text,
        cardCVV: cvvController.text,
        EXD: DateFormat('dd/MM/yyyy').parse(expiryController.text),
        bank: seletedBank!,
      );
      await CardRepository().addCard(card.toMap());
      Get.back();
    } else {
      Fluttertoast.showToast(msg: "The information you provided is incorrect");
    }
    load = false;
    update();
  }
}
