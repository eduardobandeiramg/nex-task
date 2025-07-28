import 'package:nex_task/model/models/task.dart';
import 'package:nex_task/services/database/tasks_database.dart';

class TasksController {
  static createTask(Task task) async {
    await TasksDatabase.createTask(task);
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    var response = await TasksDatabase.getTasks();
    print("RESPOSTA DO GET TASKS PARA O CONTROLLER: $response");
    return response;
  }
}
