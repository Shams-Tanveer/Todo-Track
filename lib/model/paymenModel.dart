import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentFields{
  static const String userId = "userId";
  static const String paymentId = "paymentId"; 
  static const String amount = "amount";
  static const String createdAt = "createdAt"; 
}

class Payment{
  String userId;
  String paymentId;
  String amount;
  DateTime createdAt;

  Payment({
    required this.userId,
    required this.paymentId,
    required this.amount,
    required this.createdAt
  });

  Map<String, dynamic> toJson()=>{
    PaymentFields.userId: userId,
    PaymentFields.paymentId: paymentId,
    PaymentFields.amount: amount,
    PaymentFields.createdAt: createdAt
  };

  static Payment fromJson(Map<String, Object?> json) => Payment(
    userId: json[PaymentFields.userId] as String, 
    paymentId: json[PaymentFields.paymentId] as String, 
    amount: json[PaymentFields.amount] as String, 
    createdAt: (json[PaymentFields.createdAt] as Timestamp).toDate());
}