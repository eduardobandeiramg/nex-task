import 'package:flutter/material.dart';
import '../../../services/database/tasks_database.dart';
import '../../screens/navigation_screen/navigation_screen.dart';

AlertDialog buildConfirmTaskDeletionBanner({
  required String taskId,
  required BuildContext context,
}) {
  return AlertDialog(
    title: Text("Confirm task deletion?"),
    content: Text("this action cannot be undone"),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text("cancel"),
      ),
      TextButton(
        onPressed: () async {
          await TasksDatabase.deleteTask(taskId);
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (context) => NavigationScreen()));
        },
        child: Text("confirm"),
      ),
    ],
  );
}
