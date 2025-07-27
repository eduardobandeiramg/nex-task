import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nex_task/view/state_management/supabase_client_storage.dart';

class AuthService {
  final supabaseClient = SupabaseClientStorage.supabaseClient;

  // method for creating a new user
  Future<Map<String, dynamic>> createUser(String email, String password) async {
    final AuthResponse res = await supabaseClient.auth.signUp(email: email, password: password);
    final Session? session = res.session;
    final User? user = res.user;

    return {"session": session, "user": user};
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final AuthResponse authResponse = await Supabase.instance.client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final Session? session = authResponse.session;
    final User? user = authResponse.user;

    return {"session": session, "user": user};
  }

  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }
}
