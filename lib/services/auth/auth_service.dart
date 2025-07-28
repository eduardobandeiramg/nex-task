import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  // method for creating a new user
  Future<Map<String, dynamic>> createUser(String email, String password) async {
    final AuthResponse res = await Supabase.instance.client.auth.signUp(
      email: email,
      password: password,
    );
    final Session? session = res.session;
    final User? user = res.user;
    print("session: $session");
    print("user: $user");
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
    await Supabase.instance.client.auth.signOut();
  }
}
