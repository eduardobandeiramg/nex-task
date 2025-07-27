import 'package:flutter/material.dart';

class StandardTextFormField extends StatefulWidget {
  String hintText;

  StandardTextFormField({super.key, required this.hintText});

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
          textAlign: TextAlign.center,
          decoration: InputDecoration(border: OutlineInputBorder(), hintText: widget.hintText,),
        ),
      ),
    );
  }
}
