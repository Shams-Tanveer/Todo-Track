import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:todo_track/controller/registrationController.dart';
import 'package:todo_track/controller/signInUpController.dart';
import 'package:todo_track/screens/loginScreen.dart';

import '../components/appName.dart';
import '../components/customButton.dart';
import '../components/customColor.dart';
import '../components/customTextField.dart';
import '../components/themeswitch.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final RegistrationController _registrationController =
      Get.put(RegistrationController());
  final SignInUpController _signInUpController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(top: 10, right: 20, child: ThemeSwitch()),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .30),
                      child: const AppName()),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Please fill the form to create an account",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Obx(
                    () => CustomTextField(
                      hintText: "Email",
                      obscureText: false,
                      errorText: _registrationController.emailError.value,
                      visibilityFunction: null,
                      updateValue: _registrationController.getTextFieldEmail,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () => CustomTextField(
                      hintText: "Password",
                      obscureText:
                          _registrationController.passwordObscure.value,
                      errorText: _registrationController.passwordError.value,
                      visibilityFunction:
                          _registrationController.visibilityFunction,
                      updateValue: _registrationController.getTextFieldPassword,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() => CustomTextField(
                      hintText: "Confirm Password",
                      obscureText: false,
                      errorText:
                          _registrationController.confirmPasswordError.value,
                      visibilityFunction: null,
                      updateValue:
                          _registrationController.getTextFieldConfirmPassword),),
                  const SizedBox(
                    height: 12,
                  ),
                  MyButton(
                    text: "Sign Up",
                    onPressed: (){
                      _registrationController.signUp(context);
                    },
                    fromLeft: CustomColorConstants.buttonLightColor,
                    toRight: CustomColorConstants.buttonBrightColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(fontSize: 17),
                      ),
                      GestureDetector(
                          onTap: _signInUpController.toggleBetween,
                          child: Text(
                            "Sign In.",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
