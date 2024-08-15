import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/models/guarantee_doing.dart';

import '../models/guarantee.dart';
import '../servers/guarantee_api_server.dart';

class GuaranteeRepository {
  GuaranteeAPIServer guaranteeAPIServer = GuaranteeAPIServer();

  Future<void> addGuarantee(GuaranteeDoing guarantee) async {
    guarantee.userID = FirebaseAuth.instance.currentUser!.uid;
    await guaranteeAPIServer.add(guarantee.toMap());
  }

  Future<List<Guarantee>> getGuarantees() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('guarantees');
    List<Guarantee> guarantees = [];
    var userID = FirebaseAuth.instance.currentUser!.uid;
    await collection
        .where('userID', isEqualTo: userID)
        .get()
        .then((QuerySnapshot querySnapshot) {
      guarantees = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Guarantee a = Guarantee.fromMap(data, doc.id);
          return a;
        }
        return Guarantee.empty();
      }).toList();
    });
    return guarantees;
  }
}
