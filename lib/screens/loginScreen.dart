import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_track/components/appName.dart';
import 'package:todo_track/components/customButton.dart';
import 'package:todo_track/controller/loginController.dart';
import 'package:todo_track/controller/signInUpController.dart';
import 'package:todo_track/controller/themeController.dart';

import '../components/customColor.dart';
import '../components/customTextField.dart';
import '../components/themeswitch.dart';

/* This is the Login Screen where you can securely log in using your email and password with Firebase Authentication or conveniently sign in using your Google account. */
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController _loginController = Get.put(LoginController());
  final ThemeController _controller = Get.find();
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
                        "Login to your account",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Obx(
                    () => CustomTextField(
                      hintText: "Email",
                      obscureText: false,
                      errorText: _loginController.emailError.value,
                      visibilityFunction: null,
                      updateValue: _loginController.getTextFieldEmail,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => CustomTextField(
                      hintText: "Password",
                      errorText: _loginController.passError.value,
                      obscureText: _loginController.passwordObscure.value,
                      visibilityFunction: _loginController.visibilityFunction,
                      updateValue: _loginController.getTextFiledPassword,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  MyButton(
                    text: "Log In",
                    onPressed: () {
                      _loginController.loginUser(context);
                    },
                    fromLeft: CustomColorConstants.buttonLightColor,
                    toRight: CustomColorConstants.buttonBrightColor,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Or",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {
                        _loginController.googleLogin();
                      },
                      child: Obx(
                        () => Container(
                          width: 218,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: _controller.isDarkMode.value
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/google.png",
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "SignIn with GOOGLE",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New Here? ",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      GestureDetector(
                          onTap: _signInUpController.toggleBetween,
                          child: Text(
                            "Create an account.",
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
