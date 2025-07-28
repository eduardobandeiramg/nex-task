import 'package:nex_task/view/state_management/user_infos/user_infos.dart';
import '../enums/status.dart';
import 'dart:convert';

class Task {
  String title;
  String description;
  String dueDate;
  String category;
  TaskStatus status;
  String idUser = UserInfos.userID;

  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.status,
  });

  Map<String, String> toMap() {
    String statusText = "";
    switch (status) {
      case TaskStatus.toDo:
        statusText = "to_do";
      case TaskStatus.inProgress:
        statusText = "in_progress";
      case TaskStatus.done:
        statusText = "done";
    }
    return {
      "id_user": idUser,
      "title": title,
      "description": description,
      "due_date": dueDate,
      "category": category,
      "status": statusText,
    };
  }
}
