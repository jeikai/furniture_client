// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Payment {
  String numberCard;
  String nameHolderCard;
  DateTime expiryDate;
  Payment({
    required this.numberCard,
    required this.nameHolderCard,
    required this.expiryDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numberCard': numberCard,
      'nameHolderCard': nameHolderCard,
      'expiryDate': expiryDate.millisecondsSinceEpoch,
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      numberCard: map['numberCard'] as String,
      nameHolderCard: map['nameHolderCard'] as String,
      expiryDate: DateTime.fromMillisecondsSinceEpoch(map['expiryDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) => Payment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Payment(numberCard: $numberCard, nameHolderCard: $nameHolderCard, expiryDate: $expiryDate)';
}
