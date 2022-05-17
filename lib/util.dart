import 'package:flutter/material.dart';

Future<bool> showYesNoDialog(BuildContext context, String message) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (builderContext) {
      return AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(builderContext).pop(false),
            child: Text(
              'No',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(builderContext).pop(true),
            child: Text('Yes'),
          ),
        ],
      );
    },
  );
  return confirmed!;
}
