import 'package:get/get.dart';

class SignInUpController extends GetxController{
  var isSignIn = true.obs;

  void toggleBetween(){
    isSignIn.value = !isSignIn.value;
  }

}