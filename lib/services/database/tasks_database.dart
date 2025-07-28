import '../../model/models/task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TasksDatabase {
  static Future<dynamic> createTask(Task task) async {
    var response = await Supabase.instance.client.from("tasks").insert(task.toMap());
    print("RESPOSTA: $response");
    return response;
  }
}
