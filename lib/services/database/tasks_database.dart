import 'package:nex_task/view/state_management/user_infos/user_infos.dart';

import '../../model/models/task.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TasksDatabase {
  static Future<dynamic> createTask(Task task) async {
    var response = await Supabase.instance.client.from("tasks").insert(task.toMap());
    print("RESPOSTA DO CREATE: $response");
    return response;
  }

  static Future<dynamic> getTasks() async {
    var response = await Supabase.instance.client
        .from("tasks")
        .select()
        .eq("id_user", UserInfos.userID);
    print("RESPOSTA DO GET TASKS: $response");
    return response;
  }
}
