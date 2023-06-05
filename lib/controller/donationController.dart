import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_track/components/snackBar.dart';
import 'package:todo_track/model/paymenModel.dart';


/* This controller performs the donation process by calling the Stripe package and also collects the user donation history */
class DonationController extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  var donations = [].obs;
  var amount = "0".obs;
  var donationController = TextEditingController().obs;

  updateAmount(String value) {
    amount.value = value;
  }

  readDonations() {
    FirebaseFirestore.instance
        .collection("donations")
        .where(PaymentFields.userId,
            isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .orderBy(PaymentFields.createdAt)
        .get()
        .then((value) {
      donations.value =
          value.docs.map((e) => Payment.fromJson(e.data())).toList();
    });
  }

  Future<void> makePayment() async {
    try {
      await dotenv.load();
      paymentIntentData = await createPaymentIntent(amount.value, 'USD');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  customFlow: true,
                  merchantDisplayName: 'Todo Track'))
          .then((value) {});

      displayPaymentSheet();
    } catch (e, s) {
      SnackBarUtility.showSnackBar('Payment exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        Stripe.instance.confirmPaymentSheetPayment().then((value) {
          final payment = Payment(
                  userId: FirebaseAuth.instance.currentUser!.email!,
                  paymentId: paymentIntentData!["id"],
                  amount: paymentIntentData!["amount"].toString(),
                  createdAt: DateTime.now())
              .toJson();
          FirebaseFirestore.instance
              .collection("donations")
              .add(payment)
              .then((value) {
            donationController.value.clear();
            readDonations();
            SnackBarUtility.showSnackBar("Payment Successful");
          });
        });
      }).onError((error, stackTrace) {
        SnackBarUtility.showSnackBar(
            'Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      SnackBarUtility.showSnackBar('Exception/DISPLAYPAYMENTSHEET==> $e');
    } catch (e) {
      SnackBarUtility.showSnackBar('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer ${dotenv.env["SECRET_KEY"]}',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      SnackBarUtility.showSnackBar('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
