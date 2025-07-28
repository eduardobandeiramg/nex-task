import 'package:flutter/material.dart';
import 'package:nex_task/utils/dimensions.dart';
import 'package:nex_task/utils/enums/text_form_field_input.dart';

class UpdatingTaskField extends StatefulWidget {
  TextFormFieldInput textFormFieldInput;
  TextEditingController controller;

  UpdatingTaskField({super.key, required this.textFormFieldInput, required this.controller});

  @override
  State<UpdatingTaskField> createState() => _UpdatingTaskFieldState();
}

class _UpdatingTaskFieldState extends State<UpdatingTaskField> {
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
        height: Dimensions.height * 0.07,
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
      return "new title";
    case TextFormFieldInput.taskDescription:
      return "new description";
    case TextFormFieldInput.newCategory:
      return "enter new category";
    case TextFormFieldInput.taskDueDate:
      return "new deadline:";
    default:
      return "not-detected text form field";
  }
}
