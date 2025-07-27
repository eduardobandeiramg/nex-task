import 'package:flutter/material.dart';
import 'package:nex_task/utils/app_color.dart';
import 'package:nex_task/utils/dimensions.dart';

class StandardButton extends StatelessWidget {
  String buttonText;

  StandardButton({super.key, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.width * 0.5,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(buttonText, style: TextStyle(color: Colors.white)),
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.primary)),
      ),
    );
  }
}
