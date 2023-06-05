import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_track/components/customColor.dart';
import 'package:todo_track/controller/themeController.dart';

class DateBoxWidget extends StatelessWidget {
  DateTime dateTime;
  int selectedDate;
  DateBoxWidget({Key? key, required this.dateTime,required this.selectedDate});


  ThemeController _controller =  Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMM');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: dateTime.day==selectedDate? CustomColorConstants.buttonLightColor:null,
          border: Border(
            bottom: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formatter.format(dateTime),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateFormat('EE').format(dateTime),
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
