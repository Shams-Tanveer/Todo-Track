import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_track/screens/homeScreen.dart';
import 'package:todo_track/screens/todoScreen.dart';
import 'components/bottomNavigator.dart';
import 'components/snackBar.dart';
import 'controller/themeController.dart';
import 'theme/thememanagement.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ThemeController());
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        scaffoldMessengerKey: SnackBarUtility.messengerKey,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeManagement.lightTheme,
        darkTheme: ThemeManagement.darkTheme,
        home: Scaffold(
          body: SafeArea(
            child: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child:
                          SnackBarUtility.showSnackBar("Something went wrong"),
                    );
                  } else if (snapshot.hasData) {
                    return Center(
                      child: Scaffold(
                        bottomNavigationBar: BottomNavigationWidget(),
                      ),
                    );
                  } else {
                    return HomeScreen();
                  }
                }),
          ),
        ));
  }
}
