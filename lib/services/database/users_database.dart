import 'package:nex_task/view/state_management/user_infos/user_infos.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsersDatabase {
  static Future<void> addNewUserToProfilesTable() async {
    await Supabase.instance.client.from("profiles").insert(UserInfos.userID);
  }
}
