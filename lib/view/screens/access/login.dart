import 'package:flutter/material.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/utils/enums/button_types.dart';
import 'package:nex_task/view/components/buttons/standard_button.dart';
import 'package:nex_task/view/components/text_form_fields/standard_text_form_field.dart';
import 'package:nex_task/utils/enums/text_form_field_input.dart';
import 'package:nex_task/view/screens/access/register.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height * 0.1),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Log-in",
                  style: TextStyle(fontSize: Dimensions.height * 0.04, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: Dimensions.height * 0.1),
              StandardTextFormField(
                textFormFieldInput: TextFormFieldInput.email,
                controller: emailController,
              ),
              StandardTextFormField(
                textFormFieldInput: TextFormFieldInput.password,
                controller: passwordController,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text("sign-up", style: TextStyle(color: Theme.of(context).primaryColor)),
              ),
              SizedBox(height: Dimensions.height * 0.1),
              StandardButton(buttonTypes: ButtonTypes.login, email: emailController.text, password1: passwordController.text,),
            ],
          ),
        ),
      ),
    );
  }
}
