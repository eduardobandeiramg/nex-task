import 'package:flutter/material.dart';
import '../../../services/database/tasks_database.dart';
import '../../screens/navigation_screen/navigation_screen.dart';

AlertDialog buildConfirmTaskStatusChangeBanner({
  required String taskId,
  required BuildContext context,
  required String newStatus,
}) {
  return AlertDialog(
    title:
        newStatus == "in_progress"
            ? Text("Confirm start of task execution?")
            : Text("Confirm task completion?"),
    content:
        newStatus == "in_progress"
            ? Text("this task's state will be updated to 'in progress'")
            : Text("this task's state will be updated to 'done'"),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("cancel"),
      ),
      TextButton(
        onPressed: () async {
          await TasksDatabase.updateTaskStatus(taskId, newStatus);
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (context) => NavigationScreen()));
        },
        child: Text("confirm"),
      ),
    ],
  );
}
