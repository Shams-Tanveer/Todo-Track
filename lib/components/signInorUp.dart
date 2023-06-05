import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todo_track/controller/signInUpController.dart';
import 'package:todo_track/screens/loginScreen.dart';
import 'package:todo_track/screens/registrationScreen.dart';

class SignInOrUp extends StatefulWidget {
  SignInOrUp({super.key});

  @override
  State<SignInOrUp> createState() => _SignInOrUpState();
}

class _SignInOrUpState extends State<SignInOrUp> {
  final SignInUpController _signInUpController = Get.put(SignInUpController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _signInUpController.isSignIn.value? LoginScreen():RegistrationScreen());
  }
}