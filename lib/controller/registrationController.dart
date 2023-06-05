import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:todo_track/components/customColor.dart';
import '../components/snackBar.dart';
import '../main.dart';
import '../model/userModel.dart';

class RegistrationController extends GetxController {
  var email = "".obs;
  var emailError = "".obs;
  var password = "".obs;
  var passwordError = "".obs;
  var confirmPassword = "".obs;
  var confirmPasswordError = "".obs;

  var passwordObscure = true.obs;

  visibilityFunction() {
    passwordObscure.value = !passwordObscure.value;
  }

  getTextFieldEmail(String value) {
    email.value = value;
  }

  getTextFieldPassword(String value) {
    password.value = value;
  }

  getTextFieldConfirmPassword(String value) {
    confirmPassword.value = value;
  }

  validateTextField() {
    if (email.isEmpty) {
      emailError.value = "Enter your email";
    } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
        .hasMatch(email.value)) {
      emailError.value = "Enter a valid email ";
    } else {
      emailError.value = "";
    }

    if (password.isEmpty) {
      passwordError.value = "Enter your password";
    } else if (!RegExp(r"^.{6,}$").hasMatch(password.value)) {
      passwordError.value = "Enter password(Min 6 Character)";
    } else {
      passwordError.value = "";
    }

    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = "Enter the password again";
    } else {
      if (confirmPassword.value != password.value) {
        confirmPasswordError.value =
            "Password and Confirm password donot match";
      } else {
        confirmPasswordError.value = "";
      }
    }

    if (emailError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty) {
      return true;
    }
  }

  Future<void> signUp(BuildContext context) async {
    if (validateTextField()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(
                color: CustomColorConstants.buttonBrightColor,
              ),
            );
          });
      try {
        final user = User(email: email.value).toJson();
        await auth.FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.value.trim(), password: password.value.trim())
            .then((credential) {
          if (credential != null) {
            FirebaseFirestore.instance
                .collection("users")
                .add(user)
                .then((value) {
              user["id"] = value.id;
              value.set(user);
            });
          } else {
            SnackBarUtility.showSnackBar("Registration Failed");
          }
        });
      } on auth.FirebaseAuthException catch (e) {
        SnackBarUtility.showSnackBar(e.message);
      } catch (e) {
        SnackBarUtility.showSnackBar(e.toString());
      }

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }else{
      print("No");
    }
  }
}
