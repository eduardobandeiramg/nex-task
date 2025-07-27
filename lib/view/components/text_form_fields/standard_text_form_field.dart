import 'package:flutter/material.dart';
import 'package:nex_task/utils/enums/text_form_field_input.dart';

class StandardTextFormField extends StatefulWidget {
  TextFormFieldInput textFormFieldInput;
  TextEditingController controller;

  StandardTextFormField({super.key, required this.textFormFieldInput, required this.controller});

  @override
  State<StandardTextFormField> createState() => _StandardTextFormFieldState();
}

class _StandardTextFormFieldState extends State<StandardTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: TextFormField(
          onChanged: (value) {
            print("NOVO VALOR: $value");
          },
          controller: widget.controller,
          obscureText:
              widget.textFormFieldInput == TextFormFieldInput.password ||
                      widget.textFormFieldInput == TextFormFieldInput.confirmPassword
                  ? true
                  : false,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: textFormFieldText(widget.textFormFieldInput),
          ),
        ),
      ),
    );
  }
}

String textFormFieldText(TextFormFieldInput textFormFieldInput) {
  switch (textFormFieldInput) {
    case TextFormFieldInput.email:
      return "email";
      break;
    case TextFormFieldInput.password:
      return "password";
      break;
    case TextFormFieldInput.confirmPassword:
      return "confirm password";
      break;
  }
}
