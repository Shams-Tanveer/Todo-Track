import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todo_track/components/customColor.dart';
import 'package:todo_track/controller/apiController.dart';

/* This Screen is used to show details of a laptop. Basically when user select a laptop user is redirect to this page to show the details of the laptop. */
class ApiDetailsScreen extends StatelessWidget {
  ApiDetailsScreen({super.key});

  final ApiController _apiController = Get.find();

  @override
  Widget build(BuildContext context) {
    _apiController
        .getSelectedLaptopInfo(); //The Controller call the api to get the details of the laptop.
    return Scaffold(
        body: Obx(() => SafeArea(
            child: _apiController.selectedLaptop.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(
                      color: CustomColorConstants.buttonBrightColor,
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CarouselSlider(
                                  options: CarouselOptions(
                                    height: 200.0,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    aspectRatio: 16 / 9,
                                  ),
                                  items: (_apiController
                                          .selectedLaptop["images"] as List)
                                      .map((item) => Container(
                                            margin: const EdgeInsets.all(5.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              child: Image.network(item,
                                                  fit: BoxFit.fill),
                                            ),
                                          ))
                                      .toList()),
                              Center(
                                child: Text(
                                  _apiController.selectedLaptop["name"],
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Lato"),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Container(
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Brand : ${_apiController.selectedLaptop["brand"].toString().capitalize}',
                                      style: const TextStyle(
                                          fontSize: 18, fontFamily: "Lato"),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Processor : ${_apiController.selectedLaptop["processor"].toString().capitalize}',
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: "Lato"),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Storage : ${_apiController.selectedLaptop["storage"].toString().capitalize}',
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: "Lato"),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Operating System : ${_apiController.selectedLaptop["operatingSystem"].toString().capitalize}',
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: "Lato"),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      _apiController.selectedLaptop["stock"] > 0
                                          ? "In Stock"
                                          : "Out of Stock",
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: "Lato"),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      'Price : ${_apiController.selectedLaptop["price"].toString().capitalize} BDT',
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: "Lato"),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '${_apiController.selectedLaptop["description"].toString().capitalize}',
                                      style: const TextStyle(
                                          fontSize: 16, fontFamily: "Lato"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))));
  }
}
