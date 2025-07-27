import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nex_task/utils/enums/authentication_state.dart';
import 'package:nex_task/view/state_management/supabase_client_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends Cubit<AuthenticationState> {
  AuthenticationState authenticationState = AuthenticationState.loggedOut;
  final supabaseClient = Supabase.instance.client; //SupabaseClientStorage.supabaseClient;

  AuthGate() : super(AuthenticationState.loggedOut) {
    _listenToAuthEvents();
  }

  void _listenToAuthEvents() {
    supabaseClient.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      final Session? session = data.session;
      print('EVENTO: $event, SESSÃO: $session');
      switch (event) {
        case AuthChangeEvent.signedIn || AuthChangeEvent.initialSession:
          emit(AuthenticationState.loggedIn);
        case AuthChangeEvent.signedOut:
          emit(AuthenticationState.loggedOut);
        default:
          emit(AuthenticationState.loggedOut);
      }
    });
  }
}
