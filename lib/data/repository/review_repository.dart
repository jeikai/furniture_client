import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_app/data/auth/auth_service.dart';
import 'package:furniture_app/data/models/review.dart';
import 'package:furniture_app/data/servers/review_api_server.dart';

import '../models/product.dart';

class ReviewRepository {
  Future<List<Review>> getReviewsByUser() async {
    CollectionReference collection = FirebaseFirestore.instance.collection('reviews');
    List<Review> reviews = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Review a = Review.fromMap(data, id: doc.id);
          if (data['userID'] == AuthService.userId) reviews.add(a);
          return a;
        }
        return Review.template();
      }).toList();
    });
    return reviews;
  }
  Future<List<Review>> getReviewsByProduct(Product product) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('reviews');
    List<Review> reviews = [];
    await collection.where('productID', isEqualTo: product.id).get().then((QuerySnapshot querySnapshot) {
      var result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Review a = Review.fromMap(data, id: doc.id);
          if (a.numberStart != null) reviews.add(a);
          return a;
        }
        return Review.template();
      }).toList();
    });
    return reviews;
  }

  Future<void> updateReview(Review review) async {
    if (review.id != null) await ReviewAPIServer().updateReview(review.toMap(), review.id!, review.product);
  }
}
