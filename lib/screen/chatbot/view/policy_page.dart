import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Get.height * 0.024,
          bottom: Get.height * 0.015,
          left: Get.height * 0.024,
          right: Get.height * 0.024),
      margin: EdgeInsets.only(
        top: 10,
        bottom: 10,
        left: 10,
        right: Get.width * 0.1 + 10,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: buttonColor,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            policy,
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w600,
                fontSize: Get.height * 0.025,
                color: Colors.black),
          ),
          SizedBox(height: Get.height * 0.006),
          Text(policyA,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textGrey)),
          Container(
            margin: EdgeInsets.only(
                top: Get.height * 0.021, bottom: Get.height * 0.012),
            height: Get.height * 0.0002,
            color: textGrey1Color,
          ),
          InkWell(
            child: Container(
              height: Get.height * 0.029,
              width: Get.width,
              alignment: Alignment.center,
              child: Text(
                view_post,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: Get.height * 0.02,
                    color: buttonColor),
              ),
            ),
            onTap: () {
              showModalBottomSheet<void>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(Get.height * 0.024),
                      color: backgroundColor,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: Get.height * 0.15,
                                  right: Get.height * 0.15,
                                  bottom: Get.height * 0.024),
                              height: Get.height * 0.004,
                              color: textGrey1Color,
                            ),
                            Text(
                              policy,
                              style: TextStyle(
                                  fontFamily: jose_fin_sans,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Get.height * 0.025,
                                  color: Colors.black),
                            ),
                            SizedBox(height: Get.height * 0.018),
                            text(policyA),
                            SizedBox(height: Get.height * 0.005),
                            _text(policyA1),
                            _text(policyA2),
                            _text(policyA3),
                            _text(policyA4),
                            _text(policyA5),
                            _text(policyA6),
                            SizedBox(height: Get.height * 0.015),
                            text(policyB),
                            SizedBox(height: Get.height * 0.005),
                            _text(policyB1),
                            _text(policyB2),
                            _text(policyB3),
                            _text(policyB4),
                            _text(policyB5),
                            _text(policyB6),
                            _text(policyB7),
                            SizedBox(height: Get.height * 0.015),
                            text(policyC),
                            SizedBox(height: Get.height * 0.005),
                            _text(policyC1),
                            _text(policyC2),
                            _text(policyC3),
                            _text(policyC4),
                          ],
                        ),
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }

  Widget text(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: Get.height * 0.018, color: Colors.black),
      textAlign: TextAlign.left,
    );
  }

  Widget _text(String title) {
    return Text(title,
        style: TextStyle(fontSize: Get.height * 0.0155, color: textGrey));
  }

  AppBar appBarCustom() {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: InkWell(
        onTap: () => Get.back(),
        child: SizedBox(
            height: Get.height * 0.01,
            width: Get.width * 0.01,
            child: SvgPicture.asset(icon_back, fit: BoxFit.scaleDown)),
      ),
    );
  }
}
