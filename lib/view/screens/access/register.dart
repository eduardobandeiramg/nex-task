import 'package:flutter/material.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/utils/enums/button_types.dart';
import 'package:nex_task/utils/enums/text_form_field_input.dart';
import 'package:nex_task/view/components/buttons/standard_button.dart';
import 'package:nex_task/view/components/text_form_fields/standard_text_form_field.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: IconThemeData(color: Theme.of(context).primaryColor)),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              //SizedBox(height: Dimensions.height * 0.1),
              Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "Create an account",
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
                controller: password1Controller,
              ),
              StandardTextFormField(
                textFormFieldInput: TextFormFieldInput.confirmPassword,
                controller: password2Controller,
              ),
              SizedBox(height: Dimensions.height * 0.1),
              StandardButton(
                buttonTypes: ButtonTypes.createAccount,
                email: emailController.text,
                password1: password1Controller.text,
                password2: password2Controller.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
