import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nex_task/services/database/users_database.dart';
import 'package:nex_task/utils/enums/authentication_state.dart';
import 'package:nex_task/view/state_management/user_infos/user_infos.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends Cubit<AuthenticationState> {
  AuthenticationState authenticationState = AuthenticationState.loggedOut;
  final supabaseClient = Supabase.instance.client; // SupabaseClientStorage.supabaseClient;

  AuthGate() : super(AuthenticationState.loggedOut) {
    _listenToAuthEvents();
  }

  void _listenToAuthEvents() {
    supabaseClient.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      if (event == AuthChangeEvent.signedIn && session != null) {
        final userId = session.user.id;
        UsersDatabase.addNewUserToProfilesTable(userId);
      }
      if (session != null) {
        final userId = session.user.id;
        UserInfos.userID = userId;
        UserInfos.userEmail = session.user.email;
      }
      if (event == AuthChangeEvent.initialSession) {
        if (session != null) {
          emit(AuthenticationState.loggedIn);
        } else {
          emit(AuthenticationState.loggedOut);
        }
      } else if (event == AuthChangeEvent.signedIn) {
        emit(AuthenticationState.loggedIn);
      } else if (event == AuthChangeEvent.signedOut) {
        emit(AuthenticationState.loggedOut);
      } else {
        emit(AuthenticationState.loggedOut);
      }
    });
  }
}
