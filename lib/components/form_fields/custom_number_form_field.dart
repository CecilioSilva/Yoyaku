import 'package:amiamu/services/get_currency.dart';
import 'package:flutter/material.dart';

class CustomNumberFormField extends StatelessWidget {
  final String title;
  final void Function(double) onChanged;
  final double initialValue;
  final String currency;

  const CustomNumberFormField({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.initialValue,
    required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          prefix: Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: Text(
              getCurrency(currency),
              style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
        onChanged: (String value) => onChanged(double.tryParse(value) ?? 0),
        keyboardType: TextInputType.number,
        validator: (String? value) {
          if (value == null) {
            return 'Enter a valid $title';
          } else if (!isNumeric(value)) {
            return 'Enter a valid number';
          }
          return null;
        },
        initialValue: initialValue.toString(),
      ),
    );
  }
}

bool isNumeric(String? s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
