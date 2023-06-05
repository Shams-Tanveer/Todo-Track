import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_track/components/customColor.dart';
import 'package:todo_track/components/signInorUp.dart';
import 'package:todo_track/screens/todoScreen.dart';

import '../components/customButton.dart';
import '../components/themeswitch.dart';
import '../controller/themeController.dart';
import 'loginScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  ThemeController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 30,
            right: 20,
            child: ThemeSwitch()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _controller.isDarkMode.value
                            ? AssetImage('assets/images/todoBlack.png')
                            : AssetImage('assets/images/todoWhite.png'),
                        fit: BoxFit
                            .fitWidth, // adjust the image to cover the whole container
                      ),
                    ));
              }),
              MyButton(
                text: "Get Started",
                onPressed: () {
                    Get.to(SignInOrUp());
                },
                fromLeft: CustomColorConstants.buttonLightColor,
                toRight: CustomColorConstants.buttonBrightColor,
              )
            ],
          ),
        ],
      ),
    );
  }
}