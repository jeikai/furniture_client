import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/models/guarantee_doing.dart';

import '../models/guarantee.dart';
import '../servers/guarantee_api_server.dart';
import '../servers/guarantee_doing_api_server.dart';

class GuaranteeDoingRepository {
  GuaranteeDoingAPIServer guaranteeDoingAPIServer = GuaranteeDoingAPIServer();

  // Future<void> addGuarantee(GuaranteeDoing guaranteeDoing) async {
  //   guaranteeDoing.userID = FirebaseAuth.instance.currentUser!.uid;
  //   await guaranteeDoingAPIServer.add(guaranteeDoing.toMap());
  // }

  Future<List<GuaranteeDoing>> getGuaranteesDoing() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('guarantees_doing');
    List<GuaranteeDoing> guaranteesDoing = [];
    var userID = FirebaseAuth.instance.currentUser!.uid;
    await collection
        // .where('userID', isEqualTo: userID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          GuaranteeDoing a = GuaranteeDoing.fromMap(data, doc.id);
          if (a.userID == userID) guaranteesDoing.add(a);
          return a;
        }
        return GuaranteeDoing.empty();
      }).toList();
    });
    return guaranteesDoing;
  }
}
