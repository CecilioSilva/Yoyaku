import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    Key? key,
    required this.name,
    required this.description,
    required this.onConfirm,
    this.onCancel,
    required this.confirmText,
    required this.cancelText,
  }) : super(key: key);

  final String name;
  final String description;
  final void Function() onConfirm;
  final void Function()? onCancel;
  final String confirmText;
  final String cancelText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF03071e),
      elevation: 10,
      content: Text(
        description,
        style: const TextStyle(color: Colors.orange),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text(
            confirmText,
            style: const TextStyle(color: Colors.red),
          ),
        ),
        TextButton(
          onPressed: () {
            if (onCancel != null) {
              onCancel!();
            }
            Navigator.pop(context);
          },
          child: Text(
            cancelText,
            style: const TextStyle(color: Colors.orange),
          ),
        ),
      ],
    );
  }
}
