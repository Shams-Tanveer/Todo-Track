import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_track/screens/apiScreen.dart';
import 'package:todo_track/screens/donationScreen.dart';
import 'package:todo_track/screens/todoScreen.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;

  final List<Widget> _children = [ToDoScreen(), ApiScreen(), DonationScreen()];

  void onTabTapped(int index) {
    if (index == 3) {
      //FirebaseAuth.instance.signOut();
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15
            ),
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
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
    );
  }
}
