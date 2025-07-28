import 'package:nex_task/services/database/users_database.dart';
import 'package:nex_task/view/state_management/auth_gate/auth_gate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:nex_task/view/state_management/supabase_client_storage.dart';

import '../../utils/enums/authentication_state.dart';

class AuthService {
  final supabaseClient = SupabaseClientStorage.supabaseClient;

  // method for creating a new user
  Future<Map<String, dynamic>> createUser(String email, String password) async {
    final AuthResponse res = await supabaseClient.auth.signUp(email: email, password: password);
    final Session? session = res.session;
    final User? user = res.user;
    await UsersDatabase.addNewUserToProfilesTable();
    /*    if (session != null) {
      AuthGate().emit(AuthenticationState.loggedIn);
    }*/
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
    await supabaseClient.auth.signOut();
  }
}
