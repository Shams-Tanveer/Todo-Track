import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_track/components/customColor.dart';
import 'package:todo_track/screens/taskScreen.dart';

import '../model/taskModel.dart';

class TodoItemWidget extends StatelessWidget {
  final Task task;

  TodoItemWidget({Key? key, required this.task}) : super(key: key);

  int randomNumber = Random().nextInt(5);

  final List<Color> colorList = [
    CustomColorConstants.coralColor,
    CustomColorConstants.emeraldColor,
    CustomColorConstants.indigoColor,
    CustomColorConstants.oliveGreenColor,
    CustomColorConstants.tealColor
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Card(
        color: colorList[randomNumber],
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(
            task.taskName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Lato"
            ),
          ),
          subtitle: Text(
            _truncateDescription(task.taskDescription),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: SizedBox(
            width: 35,
            child: Row(
              children: [
                Expanded(
                  child: VerticalDivider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Text(
                    task.isCompleted ? "Completed" : "To Do",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _truncateDescription(String description) {
    if (description.length <= 300) {
      return description;
    }
    return '${description.substring(0, 300)}...';
  }
}
