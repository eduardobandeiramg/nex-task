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
  VoidCallback? onPressed;
  double? dimensions;
  BuildContext? contextFromRegisterScreen;

  StandardButton({
    super.key,
    required this.buttonTypes,
    this.email,
    this.password1,
    this.password2,
    this.onPressed,
    this.dimensions,
    this.contextFromRegisterScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: dimensions != null ? dimensions : Dimensions.width * 0.5,
        child: ElevatedButton(
          onPressed: () async {
            if (onPressed != null) {
              onPressed!();
            }
            if (buttonTypes == ButtonTypes.login) {
              await UserController().login(email, password1);
            } else if (buttonTypes == ButtonTypes.createAccount) {
              await UserController().createUser(email, password1, password2);
              Navigator.pop(contextFromRegisterScreen!);
            }  else{

            }
          },
          child: Text(buttonText(buttonTypes), style: TextStyle(color: Colors.white)),
          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.primary)),
        ),
      ),
    );
  }
}

String buttonText(ButtonTypes buttonType) {
  switch (buttonType) {
    case ButtonTypes.login:
      return "login";
    case ButtonTypes.createAccount:
      return "create account";
    case ButtonTypes.createTask:
      return "create task";
    case ButtonTypes.editTask:
      return "update task information";
  }
}
