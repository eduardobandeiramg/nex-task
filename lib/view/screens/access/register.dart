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
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          //fit: BoxFit.cover,
          image: AssetImage("assets/images/app_logo/app_logo.png"),
        ),
      ),
      child: Scaffold(
        //extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(iconTheme: IconThemeData(color: Theme.of(context).primaryColor), backgroundColor: Colors.white,),
        body: SingleChildScrollView(
          child: Form(
            key: registerFormKey,
            child: Column(
              children: [
                //SizedBox(height: Dimensions.height * 0.1),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Create an account",
                    style: TextStyle(
                      fontSize: Dimensions.height * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
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
                  formKey: registerFormKey,
                  contextFromRegisterScreen: context,
                  buttonTypes: ButtonTypes.createAccount,
                  email: emailController,
                  password1: password1Controller,
                  password2: password2Controller,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
