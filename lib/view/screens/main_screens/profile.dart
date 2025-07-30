
import 'package:flutter/material.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/view/components/cards/log_out_card.dart';
import 'package:nex_task/view/components/cards/profile_card.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: Dimensions.height * 0.02),
          CircleAvatar(
            radius: Dimensions.width * 0.25,
            backgroundImage: AssetImage("assets/images/profile_standard_image/ukelele.png"),
          ),
          SizedBox(height: Dimensions.height * 0.05),
          ProfileCard(title: "e-mail", value: "value"),
          LogOutCard(),
        ],
      ),
    );
  }
}
