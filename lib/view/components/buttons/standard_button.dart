import 'package:flutter/material.dart';
import 'package:nex_task/controller/user_controller.dart';
import 'package:nex_task/utils/app_color.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/utils/enums/button_types.dart';

class StandardButton extends StatelessWidget {
  ButtonTypes buttonTypes;
  String? email;
  String? password1;
  String? password2;

  StandardButton({super.key, required this.buttonTypes, this.email, this.password1, this.password2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Dimensions.width * 0.5,
      child: ElevatedButton(
        onPressed: () async {
          if(buttonTypes == ButtonTypes.login){

          }
          else if(buttonTypes == ButtonTypes.createAccount){
            await UserController().createUser(email, password1, password2);
          }else{

          }
        },
        child: Text(buttonText(buttonTypes), style: TextStyle(color: Colors.white)),
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.primary)),
      ),
    );
  }
}

String buttonText(ButtonTypes buttonType) {
  switch (buttonType) {
    case ButtonTypes.login:
      return "login";
      break;
    case ButtonTypes.createAccount:
      return "create account";
      break;
  }
}
