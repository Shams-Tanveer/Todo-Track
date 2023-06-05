import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../model/taskModel.dart';


/*Responsible for streaming the added task list and to select the a specific task to see details */
class ToDoController extends GetxController {
  var selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .obs;

  setSelectedDate(DateTime date) {
    selectedDate.value = DateTime(date.year, date.month, date.day);
  }


  var selectedTask =Task(taskName: "", taskDescription: "", createdAt: DateTime.now(), isCompleted: false).obs;


  setSelectedTask(Task task){
    selectedTask.value = task;
  }

  Stream<List<Task>> readTasks() => FirebaseFirestore.instance
      .collection("tasks")
      .where(TaskFields.userId,
          isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .where(TaskFields.createdAt, isEqualTo: selectedDate.value)
      .snapshots()
      .map((snapShot) =>
          snapShot.docs.map((doc) => Task.fromJson(doc.data())).toList());
}
