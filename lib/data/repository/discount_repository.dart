import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/data/models/Discount.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/servers/discount_api_server.dart';

class DiscountRepository {
  Future<List<MyDiscount>> getDiscounts() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('discount');

    List<MyDiscount> discounts = [];
    await collection.where('time_end', isGreaterThanOrEqualTo: Timestamp.now()).get().then((QuerySnapshot querySnapshot) {
      discounts = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyDiscount a = MyDiscount.fromJson(data, doc.id);
          return a;
        }
        return MyDiscount();
      }).toList();
    });
    return discounts;
  }

  Future<MyDiscount> ramdomVoucherGame(int tries) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('discount');

    List<MyDiscount> discounts = [];
    await collection.where('time_end', isGreaterThanOrEqualTo: Timestamp.now()).get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyDiscount a = MyDiscount.fromJson(data, doc.id);
          if (a.score > tries) discounts.add(a);
          return a;
        }
        return MyDiscount();
      }).toList();
    });
    if (discounts.length > 0) return discounts[Random().nextInt(discounts.length)];
    return MyDiscount();
  }

  Future<void> addDiscountGameUser(MyDiscount discount) async {
    if (discount.id != null) await DiscountAPIServer().set(discount.toJson(), discount.id!);
  }
}
