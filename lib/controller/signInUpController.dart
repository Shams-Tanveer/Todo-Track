import 'package:get/get.dart';


/*This Controller helps to toggle between Login and Registration Page */
class SignInUpController extends GetxController{
  var isSignIn = true.obs;

  void toggleBetween(){
    isSignIn.value = !isSignIn.value;
  }

}