import 'package:furniture_app/data/repository/card_repository.dart';
import 'package:get/get.dart';

import '../../../data/models/card.dart';

class PaymentController extends GetxController {
  int isSelectCard = -1;
  List<Card> cards = [];

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void onSelected(int? index) {
    if (index != null) {
      isSelectCard = index;
      update();
    }
  }

  Future<void> loadData() async {
    String cardDefaultCode = await CardRepository().getIdCardDefalut();
    cards = await CardRepository().getCard();
    if (cardDefaultCode != 'id') {
      for (int i = 0; i < cards.length; i++) {
        if (cards[i].id == cardDefaultCode) {
          isSelectCard = i;
          break;
        }
      }
    }

    update();
  }

  Future<void> saveData() async {
    if (isSelectCard != null) {
      if (isSelectCard == -1) {
        await CardRepository().updateCardDefalut(Card.template());
      } else {
        await CardRepository().updateCardDefalut(cards[isSelectCard]);
      }
    }
  }

  void onRemove(int index) {
    cards.removeAt(index);
    update();
  }
}
