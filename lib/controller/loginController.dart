import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_track/components/customColor.dart';

import '../authentication/googleLogin.dart';
import '../main.dart';

class LoginController extends GetxController {
  var email = "".obs;
  var password = "".obs;
  var passwordObscure = true.obs;

  var emailError = "".obs;
  var passError = "".obs;

  visibilityFunction() {
    passwordObscure.value = !passwordObscure.value;
  }

  getTextFieldEmail(String value) {
    email.value = value;
  }

  getTextFiledPassword(String value) {
    password.value = value;
  }

  validateTextField() {
    if (password.isEmpty) {
      passError.value = "Please Enter Password";
    } else {
      passError.value = "";
    }

    if (email.isEmpty) {
      emailError.value = "Please Enter Email";
    } else {
      emailError.value = "";
    }

    if (emailError.isEmpty && passError.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  loginUser(BuildContext context) async {
    if (validateTextField()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(
                color: CustomColorConstants.buttonBrightColor,
              ),
            );
          });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.value.trim(), password: password.value.trim());
      } on FirebaseAuthException catch (e) {
        print(e);
      }

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }
  }

  googleLogin() {
    GoogleServices.signInWithGoogle();
  }
}
