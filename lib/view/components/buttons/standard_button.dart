import 'package:flutter/material.dart';
import 'package:nex_task/controller/user_controller.dart';
import 'package:nex_task/utils/app_color.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/utils/enums/button_types.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StandardButton extends StatelessWidget {
  ButtonTypes buttonTypes;
  TextEditingController? email;
  TextEditingController? password1;
  TextEditingController? password2;
  VoidCallback? onPressed;
  double? dimensions;
  BuildContext? contextFromRegisterScreen;
  GlobalKey<FormState>? formKey;

  StandardButton({
    super.key,
    required this.buttonTypes,
    this.email,
    this.password1,
    this.password2,
    this.onPressed,
    this.dimensions,
    this.contextFromRegisterScreen,
    this.formKey,
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
              try {
                await UserController().login(email!.text, password1!.text);
              } on AuthApiException catch (e) {
                if (e.message.contains("Invalid login credentials")) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("invalid credentials!")));
                }
              } catch (e) {}
            } else if (buttonTypes == ButtonTypes.createAccount) {
              print("PASSWORD1: ${password1!.text}");
              print("PASSWORD2: ${password2!.text}");
              print("PASSWORD1 == PASSWORD2: ${password1 == password2}");
              if (formKey != null) {
                if (formKey!.currentState!.validate()) {
                  if (password1!.text != password2!.text) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("both passwords must be identical")));
                  } else {
                    await UserController().createUser(
                      email!.text,
                      password1!.text,
                      password2!.text,
                    );
                    Navigator.pop(contextFromRegisterScreen!);
                  }
                }
              }
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
