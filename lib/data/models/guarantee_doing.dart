import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:furniture_app/data/models/Order.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/models/user_profile.dart';

class GuaranteeDoing {
  String? id;
  String orderID;
  String productID;
  Product product;
  String userID;
  UserProfile user;
  String? Error;
  List<String>? imagePath;
  DateTime time = DateTime.now();
  List<StatusOrder> status;

  GuaranteeDoing({
    this.id,
    required this.status,
    required this.orderID,
    required this.productID,
    required this.product,
    required this.userID,
    required this.user,
    this.Error,
    this.imagePath,
    required time,
  });

  GuaranteeDoing copyWith({
    String? id,
    String? orderID,
    String? productID,
    Product? product,
    String? userID,
    UserProfile? user,
    String? Error,
    List<String>? imagePath,
    List<StatusOrder>? status,
  }) {
    return GuaranteeDoing(
        id: id ?? this.id,
        orderID: orderID ?? this.orderID,
        productID: productID ?? this.productID,
        product: product ?? this.product,
        userID: userID ?? this.userID,
        user: user ?? this.user,
        Error: Error ?? this.Error,
        imagePath: imagePath,
        status: status ?? this.status,
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
      'status': status.map((x) => x.toMap()).toList(),
    };
  }

  factory GuaranteeDoing.empty() {
    return GuaranteeDoing(
      status: [],
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

  factory GuaranteeDoing.fromMap(Map<String, dynamic> map, String id) {
    return GuaranteeDoing(
      id: id,
      orderID: map['orderID'] as String,
      productID: map['productID'] as String,
      status: List<StatusOrder>.from(
        (map['status'] as List<dynamic>).map<StatusOrder>(
          (x) => StatusOrder.fromMap(x as Map<String, dynamic>),
        ),
      ),
      product: Product.fromJson(
          map['product'] as Map<String, dynamic>, map['productID'] as String),
      userID: map['userID'] as String,
      user: UserProfile.fromJson(
          map['user'] as Map<String, dynamic>, map['userID'] as String),
      Error: map['error'] != null ? map['error'] as String : null,
      imagePath:
          map['imagePath'] != null ? List<String>.from(map['imagePath']) : null,
      time: map['created_time'] != null
          ? (map['created_time'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GuaranteeDoing.fromJson(String source) =>
      GuaranteeDoing.fromMap(json.decode(source) as Map<String, dynamic>, "");

  @override
  String toString() {
    return 'Guarantee(id: $id, orderID: $orderID, productID: $productID, product: $product, userID: $userID, user: $user, Error: $Error, imagePath: $imagePath)';
  }

  @override
  bool operator ==(covariant GuaranteeDoing other) {
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
