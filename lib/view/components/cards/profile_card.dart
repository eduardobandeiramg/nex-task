import 'package:flutter/material.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/view/state_management/user_infos/user_infos.dart';

class ProfileCard extends StatelessWidget {
  String title;
  String value;

  ProfileCard({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 3, right: 3, top: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 3, color: Colors.grey),
        ),
        height: Dimensions.height * 0.07,
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text("$title: ${UserInfos.userEmail}"),
                ),
              ),
            ),
            /*            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("$title: ${UserInfos.userEmail}"),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
