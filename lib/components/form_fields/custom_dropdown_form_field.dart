import 'package:flutter/material.dart';

class CustomDropDownField extends StatelessWidget {
  final List<CustomDropdownValue> items;
  final void Function(String?) onChanged;
  final String title;
  final String? initalValue;

  const CustomDropDownField({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.title,
    this.initalValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: const Color.fromARGB(255, 23, 28, 55),
            ),
            child: DropdownButtonFormField<String>(
              value: initalValue,
              style: const TextStyle(
                fontSize: 20,
              ),
              decoration: InputDecoration(
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
              hint: Text(title),
              items: items
                  .map((e) => DropdownMenuItem<String>(
                        child: Text(
                          e.name,
                          style: const TextStyle(
                            color: Colors.orange,
                          ),
                        ),
                        value: e.value,
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomDropdownValue {
  String value;
  String name;

  CustomDropdownValue({
    required this.value,
    required this.name,
  });
}
