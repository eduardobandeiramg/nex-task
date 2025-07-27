import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nex_task/view/state_management/supabase_client_storage.dart';

class AuthService {
  var supabaseClient = SupabaseClientStorage.supabaseClient;

  // method for creating a new user
  Future<Map<String, dynamic>> createUser(String email, String password) async {
    final AuthResponse res = await supabaseClient.auth.signUp(email: email, password: password);
    final Session? session = res.session;
    final User? user = res.user;

    return {"session": session, "user": user};
  }
}
