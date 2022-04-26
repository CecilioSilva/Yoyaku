import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String title;
  final void Function(String)? onChanged;
  final String initialValue;

  const CustomTextFormField({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintText: title,
          labelText: title,
          labelStyle: const TextStyle(
            color: Colors.orange,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent),
          ),
        ),
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        validator: (String? value) {
          if (value == null) {
            return 'Enter a valid $title';
          }
          return null;
        },
        initialValue: initialValue,
      ),
    );
  }
}
