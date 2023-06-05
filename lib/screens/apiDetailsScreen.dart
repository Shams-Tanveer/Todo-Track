import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todo_track/components/customColor.dart';
import 'package:todo_track/controller/apiController.dart';

class ApiDetailsScreen extends StatelessWidget {
  ApiDetailsScreen({super.key});

  final ApiController _apiController = Get.find();

  @override
  Widget build(BuildContext context) {
    _apiController.getSelectedLaptopInfo();
    return Scaffold(
      body: Obx(() => SafeArea(
          child: _apiController.selectedLaptop.value=={} ? const Center(child: CircularProgressIndicator(color: CustomColorConstants.buttonBrightColor),) : Column(
        children: [
          Obx(() => Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 0.8,
                    ),
                    items: _apiController.selectedLaptop.value["images"].map((imageUrl) {
                      print(imageUrl);
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _apiController.selectedLaptop["name"],
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Lato"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),)
        ],
      )),)
    );
  }
}
