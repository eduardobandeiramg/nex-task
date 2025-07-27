import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nex_task/utils/app_color.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/utils/enums/authentication_state.dart';
import 'package:nex_task/utils/supabase_consts.dart';
import 'package:nex_task/view/screens/access/login.dart';
import 'package:nex_task/view/screens/navigation_screen/navigation_screen.dart';
import 'package:nex_task/view/state_management/auth_gate/auth_gate.dart';
import 'package:nex_task/view/state_management/supabase_client_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  SupabaseClientStorage.supabaseClient = Supabase.instance.client;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Dimensions.height = MediaQuery.of(context).size.height;
    Dimensions.width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => AuthGate(),
      child: MaterialApp(
        title: 'Nex Task',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(78, 171, 233, 1),
          primarySwatch: AppColors.primarySwatch,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthGate, AuthenticationState>(
          builder: (context, state) {
            if (state == AuthenticationState.loggedIn) {
              return NavigationScreen();
            } else {
              return Login();
            }
          },
        ), //NavigationScreen(),
      ),
    );
  }
}
