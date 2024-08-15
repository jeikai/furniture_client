import 'package:furniture_app/screen/game_voucher/view/game_voucher_page.dart';
import 'package:get/get.dart';

import '../../../data/models/Discount.dart';
import '../../../data/repository/discount_repository.dart';

class GameVoucherController extends GetxController {
  int tries = 0;
  int score = 0;
  Game isgame = Game();
  MyDiscount? discounts;
  bool load = false;

  void onInit() {
    super.onInit();
    isgame.initGame();
  }

  Future<void> loadDiscount() async {
    discounts = await DiscountRepository().ramdomVoucherGame(tries);
    update();
  }

  void onSelectedCard(int index) {
    tries++;
    isgame.gameImg![index] = isgame.cards_list[index];
    isgame.matchCheck.add({
      index: isgame.cards_list[index]
    });
    update();
  }

  void onSelectedCard2(int index) {
    isgame.gameImg![isgame.matchCheck[0].keys.first] = isgame.hiddenCardpath;
    isgame.gameImg![isgame.matchCheck[1].keys.first] = isgame.hiddenCardpath;
    isgame.matchCheck.clear();
    update();
  }

  void onRestart() {
    tries = 0;
    score = 0;
    isgame.initGame();
    discounts = null;
    update();
  }

  Future<void> getVoucher() async {
    if (discounts != null) await DiscountRepository().addDiscountGameUser(discounts!);
    onRestart();
  }
}
