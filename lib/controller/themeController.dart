import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';


/*It is used to toggle between dark and light mode */
class ThemeController extends GetxController{
  var isDarkMode = (SchedulerBinding.instance.window.platformBrightness == Brightness.dark).obs;
  
  void changeTheme() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
    isDarkMode.value = !isDarkMode.value;
  }
}