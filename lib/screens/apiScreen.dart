import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todo_track/components/laptopCard.dart';
import 'package:todo_track/controller/apiController.dart';
import 'package:todo_track/screens/apiDetailsScreen.dart';

import '../components/customColor.dart';
import '../components/themeswitch.dart';


/*This screen is used to fetch and show laptop. The information is collected through my personal api.*/
class ApiScreen extends StatelessWidget {
  ApiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiController _apiController = Get.put(ApiController());
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(top: 10, right: 20, child: ThemeSwitch()),
          Obx(() => Container(
                padding: EdgeInsets.only(top: 60),
                child: _apiController.laptopList.length == 0
                    ? Center(
                        child: CircularProgressIndicator(color: CustomColorConstants.buttonBrightColor,),
                      )
                    : ListView.builder(
                        itemCount: _apiController.laptopList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var laptop = _apiController.laptopList[index];
                          return Container(
                            color: CustomColorConstants.buttonBrightColor,
                            child: GestureDetector(
                              onTap: () {
                                _apiController.setSelectLaptop(laptop["_id"]);
                                Get.to(() => ApiDetailsScreen());
                              },
                              child: LaptopCard(
                                  imageUrl: laptop["images"][0],
                                  name: laptop["name"],
                                  description:
                                      '${laptop["description"].substring(0, 50)}...',
                                  rating: laptop["rating"],
                                  price: laptop["price"]),
                            ),
                          );
                        },
                      ),
              )),
        ],
      )),
    );
  }
}
