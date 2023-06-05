import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:todo_track/controller/loginController.dart';
import 'package:todo_track/controller/registrationController.dart';
import 'package:todo_track/controller/signInUpController.dart';
import 'package:todo_track/controller/taskController.dart';
import 'package:todo_track/controller/todoController.dart';
import '../controller/addTaskController.dart';
import '../controller/apiController.dart';
import '../controller/donationController.dart';


/*Performs the navigation between the screens and logout from the system by deleting all the resources initialized. */
class BottomNavigationController extends GetxController{
  var currentIndex = 0.obs;

  void onTabTapped(int index) {
    if (index == 3) {
      FirebaseAuth.instance.signOut();
      Get.delete<AddTaskController>();
      Get.delete<ApiController>();
      Get.delete<DonationController>();
      Get.delete<LoginController>();
      Get.delete<RegistrationController>();
      Get.delete<SignInUpController>();
      Get.delete<TaskController>();
      Get.delete<ToDoController>();
      Get.delete<BottomNavigationController>();
    } else {
        currentIndex.value = index;
    }
  }
}