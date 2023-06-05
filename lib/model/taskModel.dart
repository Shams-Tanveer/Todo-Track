import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskFields{
  static const String id="id";
  static const String userId = "userId";
  static const String taskName = "name";
  static const String taskDescription =  "description";
  static const String createdAt = "createdAt";
  static const String isCompleted = "isCompleted";
}

class Task{
  String? id;
  String taskName;
  String taskDescription;
  String? userId;
  DateTime createdAt;
  bool isCompleted;

  Task({
    this.id,
    required this.taskName,
    required this.taskDescription,
    this.userId,
    required this.createdAt,
    required this.isCompleted
  });

  Map<String, dynamic> toJson()=>{
    TaskFields.id:id,
    TaskFields.taskName:taskName,
    TaskFields.taskDescription: taskDescription,
    TaskFields.userId: userId,
    TaskFields.createdAt: createdAt,
    TaskFields.isCompleted: isCompleted,

  };

  static Task fromJson(Map<String, Object?> json) => Task(
    id: json[TaskFields.id] as String,
    taskName: json[TaskFields.taskName] as String,
    taskDescription: json[TaskFields.taskDescription] as String,
    userId: json[TaskFields.userId] as String,
    createdAt: (json[TaskFields.createdAt] as Timestamp).toDate(),
    isCompleted: json[TaskFields.isCompleted] as bool
  );

}