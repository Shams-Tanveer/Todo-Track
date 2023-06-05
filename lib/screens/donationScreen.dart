import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_track/components/customButton.dart';
import 'package:todo_track/controller/donationController.dart';
import 'package:todo_track/model/paymenModel.dart';

import '../components/customColor.dart';


/*This screen is used to donate and to get the donation information of an user. User can donate through Stripe.*/
class DonationScreen extends StatelessWidget {
  DonationScreen({super.key});

  final DonationController _donationController = Get.put(DonationController());
  @override
  Widget build(BuildContext context) {
    _donationController.readDonations();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            Text(
              'Enter Donation Amount:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Container(
              width: 250.0,
              child: Obx(() => TextField(
                    controller: _donationController.donationController.value,
                    keyboardType: TextInputType.number,
                    cursorColor: CustomColorConstants.buttonBrightColor,
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        hintText: 'Amount'),
                    onChanged: (value) {
                      _donationController.updateAmount(value);
                    },
                  )),
            ),
            SizedBox(height: 20.0),
            Container(
              width: 250,
              child: MyButton(
                  text: "Donate",
                  onPressed: () {
                    _donationController.makePayment();
                  },
                  fromLeft: CustomColorConstants.buttonLightColor,
                  toRight: CustomColorConstants.buttonBrightColor),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: _donationController.donations.value.length,
                  itemBuilder: (context, index) {
                    var payment = _donationController.donations.value[index];
                    return ListTile(
                      title: Text(
                        "Donated",
                        style: TextStyle(fontFamily: "Lato", fontSize: 20),
                      ),
                      subtitle: Text('${payment.amount} BDT',
                          style: TextStyle(fontFamily: "Lato", fontSize: 18)),
                      trailing: Text(
                          DateFormat('yMMMd').format(payment.createdAt),
                          style: TextStyle(fontFamily: "Lato", fontSize: 18)),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
