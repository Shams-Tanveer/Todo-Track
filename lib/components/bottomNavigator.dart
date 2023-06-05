import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_track/components/customColor.dart';
import 'package:todo_track/controller/bottonNavigatorController.dart';
import 'package:todo_track/screens/apiScreen.dart';
import 'package:todo_track/screens/donationScreen.dart';
import 'package:todo_track/screens/todoScreen.dart';

class BottomNavigationWidget extends StatelessWidget {
  BottomNavigationWidget({super.key});

  final List<Widget> _children = [ToDoScreen(), ApiScreen(), DonationScreen()];
  final BottomNavigationController _bottomNavigationController =
      Get.put(BottomNavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _children[_bottomNavigationController.currentIndex.value],),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: CustomColorConstants.buttonBrightColor, width: 2)),
        child: BottomNavigationBar(
              selectedLabelStyle:
                  const TextStyle(color: Colors.black, fontSize: 15),
              selectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              currentIndex: _bottomNavigationController.currentIndex.value,
              onTap: _bottomNavigationController.onTabTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.list_alt_outlined),
                  label: 'Todo List',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.api_outlined),
                  label: 'API',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_outlined),
                  label: 'Donation',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Colors.black,
                  icon: Icon(Icons.logout_outlined),
                  label: 'LogOut',
                ),
              ],
            ),
      ),
    );
  }
}
