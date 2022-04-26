import 'package:flutter/material.dart';

class CustomCheckboxFormField extends StatefulWidget {
  final String title;
  final Function(bool) onChanged;
  final bool initalValue;

  const CustomCheckboxFormField({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.initalValue,
  }) : super(key: key);

  @override
  State<CustomCheckboxFormField> createState() =>
      _CustomCheckboxFormFieldState();
}

class _CustomCheckboxFormFieldState extends State<CustomCheckboxFormField> {
  bool value = false;

  @override
  void initState() {
    super.initState();
    value = widget.initalValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.all(Colors.orange),
              value: value,
              onChanged: (bool? newValue) {
                if (newValue != null) {
                  value = newValue;
                  widget.onChanged(value);

                  setState(() {});
                }
              },
            ),
          ),
          Text(
            widget.title,
            style: TextStyle(
              color: value ? Colors.redAccent : Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
