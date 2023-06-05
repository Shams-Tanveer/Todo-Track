import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../authentication/googleLogin.dart';

class LoginController extends GetxController{
  var email = "".obs;
  var password = "".obs;
  var passwordObscure = true.obs;

  var emailError = "".obs;
  var passError = "".obs;


  visibilityFunction() {
      passwordObscure.value = !passwordObscure.value;

  }

  getTextFieldEmail(String value){
    email.value = value;
  }

  getTextFiledPassword(String value){
    password.value = value;
  }

  validateTextField(){
    if(password.isEmpty){
      passError.value = "Please Enter Password";
    }else{
      passError.value = "";
    }

    if(email.isEmpty){
      emailError.value = "Please Enter Email";
    }else{
      emailError.value = "";
    }

    if(emailError.isEmpty && passError.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  loginUser(){
    if(validateTextField()){
      
    }
  }

  googleLogin(){
    GoogleServices.signInWithGoogle();
  }
}