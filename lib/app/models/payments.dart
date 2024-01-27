import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentData {
  List<Payment> payments;

  PaymentData({
    required this.payments,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      payments: (json['payments'] as List<dynamic>)
          .map((e) => Payment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment': payments.map((e) => e.toJson()).toList(),
    };
  }
}

class Payment {
  String amount;
  Timestamp date_time;
  String fundraiserId;
  String name;
  String transactionId;
  String userId;
  String upiNumber;


  Payment({
   required this.amount,
    required this.date_time,
    required this.fundraiserId,
    required this.name,
    required this.transactionId,
    required this.userId,
    required this.upiNumber,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      amount: json['amount'] as String,
      date_time: json['date_time'] as Timestamp,
      fundraiserId: json['fundraiserId'] as String,
      name: json['name'] as String,
      transactionId: json['transactionId'] as String,
      userId: json['userId'] as String,
      upiNumber: json['upiNumber'] as String,
      );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'date_time': date_time,
      'fundraiserId': fundraiserId,
      'name': name,
      'transactionId': transactionId,
      'userId': userId,
      'upiNumber': upiNumber,
      };
  }
}

PaymentData fundraiserDataFromJson(String str) {
  final jsonData = json.decode(str) as Map<String, dynamic>;
  return PaymentData.fromJson(jsonData);
}

String fundraiserDataToJson(PaymentData data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
