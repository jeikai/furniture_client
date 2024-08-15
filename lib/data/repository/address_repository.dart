import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/data/servers/address_api_server.dart';

import '../models/Address.dart';

class AddressRepository {
  String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
  AddressAPIServer addressAPIServer = AddressAPIServer();

  Future<String> getIdAddressDefalut() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users/$userID/address');
    String re = '';
    await collection.doc('address').get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        re = data["default"];
      }
    });
    return re;
  }

  Future<List<Address>> getAddress() async {
    CollectionReference collection = FirebaseFirestore.instance
        .collection('users/$userID/address/address/lists');
    List<Address> address = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      address = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Address a = Address.fromMap(data, id: doc.id);
          return a;
        }
        return Address.template();
      }).toList();
    });
    return address;
  }

  Future<Address> getAddressDefault() async {
    CollectionReference collection = FirebaseFirestore.instance
        .collection('users/$userID/address/address/lists');
    String id = await getIdAddressDefalut();
    Address address = Address.template();
    await collection.doc(id).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        address = Address.fromMap(data, id: doc.id);
      }
    });
    return address;
  }

  Future<void> updateAddressDefalut(Address address) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('users/$userID/address');
    await addressAPIServer.update('address', {'default': address.id});
  }

  Future<void> addAdress(Map<String, dynamic> data) async {
    String userID = FirebaseAuth.instance.currentUser?.uid ?? "";
    await addressAPIServer.addAdress(userID, data);
  }

  Future<void> deleteListAddress(List<Address> address) async {
    for (int i = 0; i < address.length; i++) {
      await deleteAddress(address[i].id);
    }
  }

  Future<void> deleteAddress(String id) async {
    try {
      await addressAPIServer.delete(id);
      Fluttertoast.showToast(msg: "Deleted successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "Error Delete : $e");
    }
  }
}
