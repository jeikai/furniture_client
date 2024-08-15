import 'package:cloud_firestore/cloud_firestore.dart';

class MyDiscount {
  String? id;
  String? name;
  String? imageNetWork;
  DateTime? timeStart;
  DateTime? timeEnd;
  int percent = 0;
  double priceLimit = 0;
  double priceStartAllow = 0;
  int numberAllow = 0;
  bool isOffline;
  bool isOnline;
  bool isGame;
  String codeStore;
  int score;
  MyDiscount({
    this.id,
    this.name,
    this.imageNetWork,
    this.timeStart,
    this.timeEnd,
    this.percent = 0,
    this.numberAllow = 0,
    this.priceLimit = 0,
    this.priceStartAllow = 0,
    this.codeStore = "",
    this.score = 0,
    this.isOffline = false,
    this.isOnline = false,
    this.isGame = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image_network": imageNetWork,
      "time_start": timeStart != null ? Timestamp.fromDate(timeStart!) : null,
      "time_end": timeEnd != null ? Timestamp.fromDate(timeEnd!) : null,
      "percent": percent,
      "price_limit": priceLimit,
      "price_start": priceStartAllow,
      "code_store": codeStore,
      "score_game": score,
      "is_offline": isOffline,
      "is_online": isOnline,
      "is_game": isGame,
    };
  }

  factory MyDiscount.fromJson(Map<String, dynamic> data, String? id) {
    return MyDiscount(
      id: id,
      name: data["name"] ?? "",
      imageNetWork: data["image_network"] ?? [],
      timeStart: (data["time_start"] as Timestamp).toDate(),
      timeEnd: (data["time_end"] as Timestamp).toDate(),
      percent: data["percent"] ?? 0,
      numberAllow: data['number'] ?? 0,
      priceLimit: data['price_limit'] ?? 0,
      priceStartAllow: data['price_start'] ?? 0,
      codeStore: data["code_store"],
      score: data["score_game"],
      isOffline: data['is_offline'] != null ? data['is_offline'] as bool : false,
      isOnline: data['is_online'] != null ? data['is_online'] as bool : false,
      isGame: data['is_game'] != null ? data['is_game'] as bool : false,
    );
  }
}
