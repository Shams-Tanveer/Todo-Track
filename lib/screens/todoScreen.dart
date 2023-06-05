import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_track/components/customColor.dart';
import 'package:todo_track/components/dateBox.dart';
import 'package:todo_track/components/todoWidget.dart';
import 'package:todo_track/controller/addTaskController.dart';
import 'package:todo_track/controller/themeController.dart';
import 'package:todo_track/controller/todoController.dart';
import 'package:todo_track/model/taskModel.dart';
import 'package:todo_track/screens/taskScreen.dart';

import '../components/themeswitch.dart';


/*This is the To Do list screen. User can see the to do list for a specific date and can add new task.*/
class ToDoScreen extends StatelessWidget {
  ToDoScreen({super.key});

  final ThemeController _controller = Get.put(ThemeController());
  final ToDoController _toDoController = Get.put(ToDoController());
  final AddTaskController _addTaskController = Get.put(AddTaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(top: 15, right: 20, child: ThemeSwitch()),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 250,
                height: 80,
              ),
              Container(
                height: 70,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    DateTime dateTime =
                        DateTime.now().add(Duration(days: index));
                    return GestureDetector(
                        onTap: () {
                          _toDoController.setSelectedDate(dateTime);
                        },
                        child: Obx(() => DateBoxWidget(
                              dateTime: dateTime,
                              selectedDate:
                                  _toDoController.selectedDate.value.day,
                            )));
                  },
                ),
              ),
              Expanded(
                child: Obx(() => StreamBuilder<List<Task>>(
                    stream: _toDoController.readTasks(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final tasks = snapshot.data;
                          return ListView(
                            children: tasks!
                                .map((task) => GestureDetector(
                                  onTap: (){
                                    _toDoController.setSelectedTask(task);
                                    Get.to(()=>TaskWidget());
                                  },
                                  child: TodoItemWidget(task: task)))
                                .toList(),
                          );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: CustomColorConstants.buttonBrightColor,
                        ));
                      }
                    })),
              ),
            ],
          )
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: CustomColorConstants.buttonBrightColor,
        onPressed: () {
          _openAddTaskDialog(context);
        },
        icon: Icon(Icons.add),
        label: Text(
          'Add Task',
          style: TextStyle(fontSize: 18, fontFamily: "Lato"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }


/*This is used to get the information to add a task to the todo list. User will provide the name, description and date to add a task.*/
  void _openAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String taskName = '';
        String taskDescription = '';
        DateTime selectedDate = DateTime.now();

        return AlertDialog(
          title: Text(
            'Add Task',
            style: TextStyle(fontFamily: "Lato"),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() => TextField(
                      cursorColor: CustomColorConstants.buttonBrightColor,
                      decoration: InputDecoration(
                          enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          errorText: _addTaskController.nameError.value == ""
                              ? null
                              : _addTaskController.nameError.value,
                          hintText: 'Task Name'),
                      onChanged: (value) {
                        _addTaskController.setName(value);
                      },
                    )),
                const SizedBox(height: 8),
                TextField(
                  cursorColor: CustomColorConstants.buttonBrightColor,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintText: 'Description'),
                  onChanged: (value) {
                    _addTaskController.setDescription(value);
                  },
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    _addTaskController.pickDate(context);
                  },
                  child: Obx(() => TextField(
                        controller: _addTaskController.dateController.value,
                        enabled: false,
                        cursorColor: CustomColorConstants.buttonBrightColor,
                        decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            hintText: 'Pick Date'),
                      )),
                ),
                Obx(
                  () => Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _addTaskController.dateError.value == ""
                          ? ""
                          : _addTaskController.dateError.value,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColorConstants
                      .buttonBrightColor, // Set the desired background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set the desired border radius
                  ),
                ),
                onPressed: () {
                  _addTaskController.addTask(context);
                },
                child: Text(
                  "Add",
                  style: TextStyle(fontFamily: "Lato", fontSize: 16),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.redAccent, // Set the desired background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set the desired border radius
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(fontFamily: "Lato", fontSize: 16),
                ))
          ],
        );
      },
    );
  }
}
