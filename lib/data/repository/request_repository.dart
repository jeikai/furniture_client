import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/models/request_order.dart' as MyRequest;
import 'package:furniture_app/data/models/request_order.dart';
import 'package:furniture_app/data/servers/request_api_server.dart';

class RequestOrderRepository {
  RequestOrderAPIServer requestOrderAPIServer = RequestOrderAPIServer();

  Future<void> addToOrder(MyRequest.RequestOrder order) async {
    order.userID = FirebaseAuth.instance.currentUser!.uid;
    await requestOrderAPIServer.add(order.toMap());
  }

  Future<List<MyRequest.RequestOrder>> getOrders() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('request_order');
    List<MyRequest.RequestOrder> orders = [];
    var userID = FirebaseAuth.instance.currentUser!.uid;
    await collection
        .where('userID', isEqualTo: userID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      orders = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyRequest.RequestOrder a =
              MyRequest.RequestOrder.fromMap(data, id: doc.id);
          return a;
        }
        return MyRequest.RequestOrder.empty();
      }).toList();
    });
    return orders;
  }

  static String statusOrderToString(MyRequest.RequestOrder requestProduct) {
    Map<int, String> value = {
      0: "Ordered",
      1: "Preparing",
      2: "Delivery in progress",
      3: "Completed",
      4: "Cancel"
    };
    for (int i = 0; i < requestProduct.status!.length; i++) {
      if (requestProduct.status![i].date == null) {
        return value[i - 1].toString();
      }
    }
    return "Cancel";
  }
}
