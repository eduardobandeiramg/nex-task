import 'package:flutter/material.dart';
import 'package:nex_task/utils/app_color.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/view/screens/access/login.dart';
import 'package:nex_task/view/screens/navigation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Dimensions.height = MediaQuery.of(context).size.height;
    Dimensions.width = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(78, 171, 233, 1),
        primarySwatch: AppColors.primarySwatch,
      ),
      debugShowCheckedModeBanner: false,
      home: NavigationScreen(),
    );
  }
}
