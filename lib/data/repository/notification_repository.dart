import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/data/auth/auth_service.dart';
import 'package:furniture_app/data/models/notification.dart';

class NotificationRepository {
  Future<List<MyNotiInformation>> getNotificationProducts() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('users').doc(AuthService.userId).collection('notification');
    List<MyNotiInformation> notifications = [];
    await collection.orderBy('created_at', descending: true).get().then((QuerySnapshot querySnapshot) {
      notifications = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          MyNotiInformation a = MyNotiInformation.fromMap(data);
          return a;
        }
        return MyNotiInformation();
      }).toList();
    });
    return notifications;
  }
}
