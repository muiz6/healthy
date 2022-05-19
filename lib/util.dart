import 'package:flutter/material.dart';

Future<bool?> showYesNoDialog(BuildContext context, String message) async {
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
  return confirmed;
}

String getAvatarUrl(String avatarId) {
  final dict = {
    '1': 'assets/img/av_male1.jpg',
    '2': 'assets/img/av_male2.jpg',
    '3': 'assets/img/av_female1.jpg',
    '4': 'assets/img/av_female2.jpg',
  };
  return dict[avatarId]!;
}

Future<DateTime?> showMyDatePicker(
    BuildContext context, DateTime initialDate) async {
  return showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
}

String formatDate(DateTime date) {
  return '${date.day}-${date.month}-${date.year}';
}
