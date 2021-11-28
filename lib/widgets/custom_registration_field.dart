import 'package:flutter/material.dart';

class CustomRegistrationField extends StatelessWidget {
  final String label;
  final String hint;
  final controller;
  final TextInputType keyboardType;
  final validator;
  final onSave;
  final icon;

  const CustomRegistrationField({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.keyboardType,
    this.validator,
    this.onSave,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onSaved: onSave,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black26),
        hintText: hint,
        prefixIcon: icon,
        // contentPadding: EdgeInsets.all(12),
        hintStyle: TextStyle(color: Colors.black54),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          borderSide: BorderSide(color: Colors.black26),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
          borderSide: BorderSide(color: Colors.black12),
        ),
      ),
    );
  }
}
