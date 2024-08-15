import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/Discount.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/images.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/game_voucher/controller/game_voucher_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GameVoucherPage extends GetView<GameVoucherController> {
  const GameVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameVoucherController>(
        builder: (value) => Scaffold(
              body: buildBody(context, controller),
            ));
  }

  Widget buildBody(BuildContext context, GameVoucherController controller) {
    precacheImage(AssetImage(bg_game), context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bg_game), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Stack(
              children: [
                Text(
                  memory_game,
                  style: TextStyle(
                    fontSize: Get.height * 0.06,
                    fontFamily: jose_fin_sans,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 10
                      ..color = Colors.black,
                  ),
                ),
                Text(
                  memory_game,
                  style: TextStyle(fontSize: Get.height * 0.06, fontFamily: jose_fin_sans, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              infoCard("Tries", controller.tries.toString()),
              infoCard("Score", controller.score.toString()),
            ],
          ),
          SizedBox(
            height: Get.width,
            width: Get.width,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.isgame.gameImg!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 15, mainAxisSpacing: 15),
                padding: EdgeInsets.all(Get.height * 0.02),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      controller.onSelectedCard(index);
                      if (controller.isgame.matchCheck.length == 2) {
                        if (controller.isgame.matchCheck[0].values.first == controller.isgame.matchCheck[1].values.first) {
                          controller.score += 100;
                          controller.isgame.matchCheck.clear();
                        } else {
                          Future.delayed(const Duration(milliseconds: 200), () {
                            controller.onSelectedCard2(index);
                          });
                        }
                      }
                      if (controller.score == 800) {
                        await controller.loadDiscount().whenComplete(() {
                          showAlertDialog(context);
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(Get.height * 0.024),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(controller.isgame.gameImg![index]), fit: BoxFit.contain),
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 15,
          ),
          back(),
        ],
      ),
    );
  }

  Container back() {
    return Container(
      alignment: Alignment.topLeft,
      height: 75,
      width: 75,
      child: InkWell(
        child: Image.asset(
          back_game,
          fit: BoxFit.contain,
        ),
        onTap: () {
          Get.back();
        },
      ),
    );
  }

  Widget infoCard(String title, String info) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(Get.height * 0.005),
        padding: EdgeInsets.all(Get.height * 0.04),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bg_button),
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: Get.height * 0.026,
                fontWeight: FontWeight.bold,
                fontFamily: jose_fin_sans,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: Get.height * 0.007,
            ),
            Text(
              info,
              style: TextStyle(
                fontSize: Get.height * 0.04,
                fontWeight: FontWeight.bold,
                fontFamily: jose_fin_sans,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setupAlertDialoadContainer(BuildContext context) {
    //precacheImage(AssetImage(bg_game), context);
    return Container(
        width: 300,
        decoration: const BoxDecoration(
          image: DecorationImage(image: NetworkImage('https://i.gifer.com/YGg4.gif'), fit: BoxFit.cover),
        ),
        child: getVoucher(controller.discounts!, controller));
  }

  Widget getVoucher(MyDiscount discount, GameVoucherController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        Text(
          congrat_voucher,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: Get.height * 0.03, color: Colors.black, fontFamily: jose_fin_sans, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              width: 500,
              color: buttonColor,
              margin: EdgeInsets.only(
                bottom: Get.height * 0.02,
                top: Get.height * 0.005,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(Get.height * 0.0124),
                        height: Get.height * 0.1,
                        width: Get.height * 0.1,
                        color: Colors.white,
                        child: Image.asset(dis20),
                      ),
                      customDiscount(controller.discounts!.name.toString(), controller.discounts!.timeStart, controller.discounts!.timeEnd),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: textGreenColor,
              margin: EdgeInsets.only(left: Get.height * 0.02, right: Get.height * 0.0124),
              width: Get.height * 0.075,
              height: Get.height * 0.0187,
              child: Text(
                'Limited',
                style: TextStyle(
                  fontSize: Get.height * 0.015,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            btnRestart(controller),
            btnGetVou(controller),
          ],
        ),
      ],
    );
  }

  Container btnGetVou(GameVoucherController controller) {
    return Container(
      height: 60,
      width: 60,
      child: InkWell(
        child: Image.asset(
          ok_game,
          fit: BoxFit.contain,
        ),
        onTap: () {
          controller.getVoucher();
          Get.back();
        },
      ),
    );
  }

  Container btnRestart(GameVoucherController controller) {
    return Container(
      height: 60,
      width: 60,
      child: InkWell(
        child: Image.asset(
          re_game,
          fit: BoxFit.contain,
        ),
        onTap: () {
          controller.onRestart();
          Get.back();
        },
      ),
    );
  }

  Widget customDiscount(String title, DateTime? dateS, DateTime? dateE) {
    return Container(
      // width: Get.height * 0.28,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.height * 0.2,
            child: Text(
              title.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: TextStyle(
                fontSize: Get.height * 0.025,
                color: Colors.white,
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Text(
            'Effective :',
            style: TextStyle(
              fontSize: Get.height * 0.016,
              color: Colors.white,
              fontFamily: jose_fin_sans,
            ),
          ),
          Text(
            '${DateFormat('dd-MM-yyyy').format(dateS ?? DateTime.now())}  -  ${DateFormat('dd-MM-yyyy').format(dateE ?? DateTime.now())}',
            style: TextStyle(
              fontSize: Get.height * 0.016,
              color: Colors.white,
              fontFamily: jose_fin_sans,
            ),
          ),
        ],
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: backgroundColor,
          content: setupAlertDialoadContainer(context),
        );
      },
    );
  }
}

class Game {
  final String hiddenCardpath = hiddenCard;
  List<String>? gameImg;
  final List<String> cards_list = [
    img_game8,
    img_game5,
    img_game8,
    img_game1,
    img_game2,
    img_game5,
    img_game7,
    img_game6,
    img_game4,
    img_game1,
    img_game3,
    img_game2,
    img_game3,
    img_game7,
    img_game6,
    img_game4,
  ];

  List<Map<int, String>> matchCheck = [];
  final int cardCount = 16;
  void initGame() {
    cards_list.shuffle();
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
