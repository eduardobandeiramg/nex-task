import 'package:flutter/material.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/view/components/buttons/standard_button.dart';
import 'package:nex_task/view/components/text_form_fields/standard_text_form_field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

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
              StandardTextFormField(hintText: "e-mail"),
              StandardTextFormField(hintText: "password"),
              SizedBox(height: Dimensions.height * 0.1),
              StandardButton(buttonText: "login"),
            ],
          ),
        ),
      ),
    );
  }
}
