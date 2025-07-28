import 'package:supabase_flutter/supabase_flutter.dart';

class UsersDatabase {
  static Future<void> addNewUserToProfilesTable(String id) async {
    await Supabase.instance.client.from("profiles").insert({"id": id});
  }
}
