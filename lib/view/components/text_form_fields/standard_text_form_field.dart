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
  // method for returning the date picker:
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        widget.controller.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: TextFormField(
          validator: (value) {
            if (widget.textFormFieldInput == TextFormFieldInput.taskTitle) {
              if (value!.isEmpty) {
                return "enter a valid title for the task";
              } else {
                return null;
              }
            } else if (widget.textFormFieldInput == TextFormFieldInput.taskDescription) {
              if (value!.isEmpty) {
                return "enter a valid description for the task";
              } else {
                return null;
              }
            } else if (widget.textFormFieldInput == TextFormFieldInput.taskDueDate) {
              if (value!.isEmpty) {
                return "enter a valid due date for the task";
              } else {
                return null;
              }
            } else if (widget.textFormFieldInput == TextFormFieldInput.email) {
              if (value!.isEmpty) {
                return "field must be not null";
              } else if (!RegExp(
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
              ).hasMatch(value)) {
                return 'enter a valid email';
              } else {
                return null;
              }
            } else if (widget.textFormFieldInput == TextFormFieldInput.password) {
              if (value!.length < 8) {
                return 'your password must have at least 8 characters';
              } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'your password must contain at least a number';
              } else if (!RegExp('[A-Z]').hasMatch(value)) {
                return 'your password must contain at least one upper case character';
              } else if (!RegExp('[a-z]').hasMatch(value)) {
                return 'your password must contain at least one lower case character';
              }
            } else if (widget.textFormFieldInput == TextFormFieldInput.confirmPassword) {
              if (value!.length < 8) {
                return 'your password must have at least 8 characters';
              } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                return 'your password must contain at least a number';
              } else if (!RegExp('[A-Z]').hasMatch(value)) {
                return 'your password must contain at least one upper case character';
              } else if (!RegExp('[a-z]').hasMatch(value)) {
                return 'your password must contain at least one lower case character';
              }
            }
          },
          readOnly: widget.textFormFieldInput == TextFormFieldInput.taskDueDate,
          onTap: () async {
            if (widget.textFormFieldInput == TextFormFieldInput.taskDueDate) {
              return _selectDate(context);
            }
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
    case TextFormFieldInput.password:
      return "password";
    case TextFormFieldInput.confirmPassword:
      return "confirm password";
    case TextFormFieldInput.taskTitle:
      return "title";
    case TextFormFieldInput.taskDescription:
      return "description";
    case TextFormFieldInput.newCategory:
      return "enter new category";
    case TextFormFieldInput.taskDueDate:
      return "due to:";
    default:
      return "not-detected text form field";
  }
}
