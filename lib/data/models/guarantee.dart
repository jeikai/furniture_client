import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/models/user_profile.dart';

class Guarantee {
  String? id;
  String orderID;
  String productID;
  Product product;
  String userID;
  UserProfile user;
  String? Error;
  List<String>? imagePath;
  DateTime time = DateTime.now();
  Guarantee({
    this.id,
    required this.orderID,
    required this.productID,
    required this.product,
    required this.userID,
    required this.user,
    this.Error,
    this.imagePath,
    required time,
  });

  Guarantee copyWith({
    String? id,
    String? orderID,
    String? productID,
    Product? product,
    String? userID,
    UserProfile? user,
    String? Error,
    List<String>? imagePath,
  }) {
    return Guarantee(
        id: id ?? this.id,
        orderID: orderID ?? this.orderID,
        productID: productID ?? this.productID,
        product: product ?? this.product,
        userID: userID ?? this.userID,
        user: user ?? this.user,
        Error: Error ?? this.Error,
        imagePath: imagePath,
        time: DateTime.now());
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'productID': productID,
      'product': product.toJson(),
      'userID': userID,
      'user': user.toJson(),
      'error': Error,
      'imagePath': imagePath,
    };
  }

  factory Guarantee.empty() {
    return Guarantee(
      //product: [],
      time: DateTime.now(),
      orderID: '',
      productID: '',
      user: UserProfile(),
      userID: '',
      imagePath: [],
      product: Product(
          //   id: "id",
          //   caption: "caption",
          //   category: "category",
          //   description: "description",
          //   //height: "height",
          //  // imageColorTheme: "image_color_theme",
          //   imagePath: [],
          //   price: 0,
          ),
    );
  }

  factory Guarantee.fromMap(Map<String, dynamic> map, String id) {
    return Guarantee(
      id: id,
      orderID: map['orderID'] as String,
      productID: map['productID'] as String,
      product: Product.fromJson(
          map['product'] as Map<String, dynamic>, map['productID'] as String),
      userID: map['userID'] as String,
      user: UserProfile.fromJson(
          map['user'] as Map<String, dynamic>, map['userID'] as String),
      Error: map['error'] != null ? map['error'] as String : null,
      imagePath: map['imagePath'] != null
          ? List<String>.from((map['imagePath'] as List<String>))
          : null,
      time: map['created_time'] != null
          ? (map['created_time'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Guarantee.fromJson(String source) =>
      Guarantee.fromMap(json.decode(source) as Map<String, dynamic>, "");

  @override
  String toString() {
    return 'Guarantee(id: $id, orderID: $orderID, productID: $productID, product: $product, userID: $userID, user: $user, Error: $Error, imagePath: $imagePath)';
  }

  @override
  bool operator ==(covariant Guarantee other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.orderID == orderID &&
        other.productID == productID &&
        other.product == product &&
        other.userID == userID &&
        other.user == user &&
        other.Error == Error &&
        listEquals(other.imagePath, imagePath);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        orderID.hashCode ^
        productID.hashCode ^
        product.hashCode ^
        userID.hashCode ^
        user.hashCode ^
        Error.hashCode ^
        imagePath.hashCode;
  }
}
