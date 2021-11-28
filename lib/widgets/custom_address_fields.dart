import 'package:flutter/material.dart';

class CustomAddressFields extends StatelessWidget {
  final label;
  final hint;
  final controller;
  final validate;
  final save;

  const CustomAddressFields({
    Key? key,
    required this.label,
    required this.hint,
    this.controller,
    this.validate,
    this.save,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validate,
      onSaved: (v) => save,
      enableInteractiveSelection: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.black38),
        hintText: hint,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
    );
  }
}
