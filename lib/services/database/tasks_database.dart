import 'package:nex_task/view/state_management/user_infos/user_infos.dart';
import '../../model/models/task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TasksDatabase {
  static Future<void> createTask(Task task) async {
    var response = await Supabase.instance.client.from("tasks").insert(task.toMap());
    return response;
  }

  static Future<List<Map<String, dynamic>>> getTasks() async {
    var response = await Supabase.instance.client
        .from("tasks")
        .select()
        .eq("id_user", UserInfos.userID);
    return response;
  }

  static Future<List<String>> getCategories() async {
    List<String> categoriesList = [];
    List<Map<String, dynamic>> tasksList = await TasksDatabase.getTasks();
    for (var task in tasksList) {
      categoriesList.add(task["category"]);
    }
    return categoriesList;
  }

  static Future<void> deleteTask(String id) async {
    await Supabase.instance.client.from("tasks").delete().eq("id", id);
  }

  static Future<void> updateTaskStatus(String id, newStatus) async {
    await Supabase.instance.client.from("tasks").update({"status": newStatus}).eq("id", id);
  }
}
