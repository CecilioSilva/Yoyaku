import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerFormField extends StatefulWidget {
  final void Function(DateTime) onChanged;
  final String title;
  final DateTime? initialValue;

  const CustomDatePickerFormField({
    Key? key,
    required this.onChanged,
    required this.title,
    this.initialValue,
  }) : super(key: key);

  @override
  State<CustomDatePickerFormField> createState() =>
      _CustomDatePickerFormFieldState();
}

class _CustomDatePickerFormFieldState extends State<CustomDatePickerFormField> {
  final f = DateFormat.yMMMMd('en_US');
  DateTime _date = DateTime.now();
  bool changed = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _date = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.orangeAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13.0),
            child: GestureDetector(
              onTap: () async {
                _date = await showDatePicker(
                        context: context,
                        initialDate: _date,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2101),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Colors.orange,
                                onPrimary: Colors.red,
                                onSurface: Colors.white,
                              ),
                              dialogBackgroundColor: const Color(0xFF03071e),
                            ),
                            child: child!,
                          );
                        }) ??
                    _date;
                changed = true;
                widget.onChanged(_date);
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: changed ? Colors.red : Colors.orange,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    f.format(_date),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
