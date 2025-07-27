import 'package:flutter/material.dart';
import 'package:nex_task/controller/user_controller.dart';
import '../../../utils/dimensions.dart';

class LogOutCard extends StatelessWidget {
  const LogOutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3, right: 3, top: 12),
      child: InkWell(
        onTap: () async {
          await UserController().logout();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(width: 3, color: Colors.grey),
          ),
          height: Dimensions.height * 0.07,
          child: Row(
            children: [
              Expanded(flex: 3, child: Padding(padding: EdgeInsets.only(left: 20), child: Text("log-out"))),
              Expanded(flex: 1, child: Icon(Icons.logout)),
            ],
          ), //ListTile(title: Text("log-out"), trailing: Icon(Icons.logout)),
        ),
      ),
    );
  }
}
