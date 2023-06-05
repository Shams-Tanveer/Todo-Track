import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_track/model/taskModel.dart';

import '../components/customColor.dart';


/* This controller is responsible for adding new task to the to do list. */
class AddTaskController extends GetxController {
  var name = "".obs;
  var description = "".obs;
  var date = DateTime.now().obs;

  var nameError = "".obs;
  var dateError = "".obs;

  var dateController = TextEditingController().obs;

  setName(String value) {
    name.value = value;
  }

  setDescription(String value) {
    description.value = value;
  }

  setDate(DateTime value) {
    date.value = value;
    dateController.value.text = DateFormat('yMMMd').format(value);
  }

  pickDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: CustomColorConstants.buttonBrightColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value == null) {
        dateError.value = "Please Enter Date";
        return;
      }
      setDate(value);
    });
  }

  validateField() {
    if (name.isEmpty) {
      nameError.value = "Please Enter Task Name";
    } else {
      nameError.value = "";
    }

    if (date == null) {
      dateError.value = "Please Enter Date";
    } else {
      dateError.value = "";
    }

    if (nameError.isEmpty && dateError.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  addTask(BuildContext context) async {
    if (validateField()) {
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
      final user = FirebaseAuth.instance.currentUser;
      final task = Task(
              taskName: name.value,
              taskDescription: description.value,
              userId: user!.email,
              createdAt: date.value,
              isCompleted: false)
          .toJson();

      name.value = "";
      description.value = "";
      date.value = DateTime.now();
      dateController.value.clear();

      await FirebaseFirestore.instance
          .collection("tasks")
          .add(task)
          .then((value) {
        Navigator.pop(context);
        task["id"] = value.id;
        value.set(task).then((value) {
          Navigator.pop(context);
        });
      });
    }
  }
}
