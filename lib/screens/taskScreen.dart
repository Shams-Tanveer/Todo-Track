import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_track/components/customButton.dart';
import 'package:todo_track/controller/taskController.dart';
import 'package:todo_track/controller/themeController.dart';
import '../components/customColor.dart';
import '../components/themeswitch.dart';

/*This screen is used to update task information and its status.
User can change the task name, description, can mark it as complete or delete the task */
class TaskWidget extends StatelessWidget {
  TaskWidget({super.key});

  final TaskController _taskController = Get.put(TaskController());
  final ThemeController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(top: 15, right: 20, child: ThemeSwitch()),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 60),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _taskController.nameController.value,
                        cursorColor: CustomColorConstants.buttonBrightColor,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            //errorText: _addTaskController.nameError.value == ""
                            //    ? null
                            //    : _addTaskController.nameError.value,
                            labelText: 'Task Name',
                            labelStyle: TextStyle(
                                color: CustomColorConstants.buttonBrightColor)),
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _taskController.descriptionController.value,
                        cursorColor: CustomColorConstants.buttonBrightColor,
                        maxLines: 4,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                color: CustomColorConstants.buttonBrightColor)),
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 75,
                        child: MyButton(
                            text: "Mark As Complete",
                            onPressed: () {
                              _taskController.markAsCompleted();
                            },
                            fromLeft: CustomColorConstants.buttonBrightColor,
                            toRight: CustomColorConstants.buttonBrightColor),
                      ),
                      Container(
                        height: 75,
                        child: MyButton(
                            text: "Delete",
                            onPressed: () {
                              _taskController.deleteTask();
                            },
                            fromLeft: Colors.redAccent.shade200,
                            toRight: Colors.redAccent.shade200),
                      ),
                      Container(
                        height: 75,
                        child: MyButton(
                            text: "Back",
                            onPressed: () {
                              _taskController.backButton();
                            },
                            fromLeft: Colors.grey,
                            toRight: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
