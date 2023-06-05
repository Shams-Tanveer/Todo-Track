import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_track/components/snackBar.dart';
import 'package:todo_track/controller/todoController.dart';
import 'package:todo_track/model/taskModel.dart';
import 'package:todo_track/screens/todoScreen.dart';


/*This controller performs task specific work like update task, mark as complte and delete task. It also validates to check whether the name of task is empty or not. */
class TaskController extends GetxController {
  final ToDoController toDoController = Get.find();

  var nameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var nameError = "".obs;

  @override
  void onInit() {
    super.onInit();
    nameController.value.text = toDoController.selectedTask.value.taskName;
    descriptionController.value.text =
        toDoController.selectedTask.value.taskDescription;
  }

  validateField() {
    if (nameController.value.text.isEmpty) {
      nameError.value = "Please Enter Task Name";
    } else {
      nameError.value = "";
    }

    if (nameError.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  markAsCompleted() async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(toDoController.selectedTask.value.id)
          .update({TaskFields.isCompleted: true}).then((value) {
        Get.back();
      });
    } catch (e) {
      SnackBarUtility.showSnackBar("Could Not Mark the Task as Completed");
    }
  }

  deleteTask() async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(toDoController.selectedTask.value.id)
          .delete()
          .then((value) {
        Get.back();
      });
    } catch (e) {
      SnackBarUtility.showSnackBar("Could Not Delete The Task");
    }
  }

  backButton() async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(toDoController.selectedTask.value.id)
          .update({
            TaskFields.taskName: nameController.value.text.trim(),
            TaskFields.taskDescription: descriptionController.value.text.trim()}).then((value) {
        Get.back();
      });
    } catch (e) {
      SnackBarUtility.showSnackBar("Could Update Task");
    }
  }
}
