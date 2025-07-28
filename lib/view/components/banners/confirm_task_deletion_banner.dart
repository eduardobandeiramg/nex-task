import 'package:flutter/material.dart';
import '../../../services/database/tasks_database.dart';
import '../../screens/navigation_screen/navigation_screen.dart';

AlertDialog buildConfirmTaskDeletionBanner({
  required String taskId,
  required BuildContext context,
}) {
  return AlertDialog(
    title: Text("Confirm task deletion?"),
    actions: [
      TextButton(
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        },
        child: Text("Cancel"),
      ),
      TextButton(
        onPressed: () async {
          await TasksDatabase.deleteTask(taskId);
          Navigator.of(
            context,
          ).pushReplacement(MaterialPageRoute(builder: (context) => NavigationScreen()));
        },
        child: Text("Confirm"),
      ),
    ],
  );
}

/*
import 'package:flutter/material.dart';
import 'package:nex_task/services/database/tasks_database.dart';
import 'package:nex_task/view/screens/navigation_screen/navigation_screen.dart';

class ConfirmTaskDeletionBanner extends StatelessWidget{
  String taskId;
  BuildContext context;

  ConfirmTaskDeletionBanner({super.key, required this.taskId, required this.context});

  @override
  Widget build(BuildContext context) {
    return MaterialBanner(
      content: Text("confirm event deletion?"),
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
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
}
*/
