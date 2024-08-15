import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_app/data/models/card.dart';
import 'package:furniture_app/data/servers/card_api_server.dart';

class CardRepository {
  String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
  CardAPIServer cardAPIServer = CardAPIServer();

  Future<String> getIdCardDefalut() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('users/$userID/card');
    String re = '';
    await collection.doc('card').get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        re = data["default"];
      }
    });
    return re;
  }

  Future<Card> getCardDefault() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('users/$userID/card/card/lists');
    String id = await getIdCardDefalut();
    Card card = Card.template();
    await collection.doc(id).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        card = Card.fromMap(data, id: doc.id);
      }
    });
    return card;
  }

  Future<List<Card>> getCard() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('users/$userID/card/card/lists');
    List<Card> card = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      card = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Card a = Card.fromMap(data, id: doc.id);
          return a;
        }
        return Card.template();
      }).toList();
    });
    return card;
  }

  Future<void> updateCardDefalut(Card card) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('users/$userID/card');
    await cardAPIServer.update('card', {
      'default': card.id
    });
  }

  Future<void> addCard(Map<String, dynamic> data) async {
    String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
    await cardAPIServer.addCard(userID, data);
  }
}
