import 'package:flutter/material.dart';

ReportTile({
  required String imageUrl,
  required int health,
  required String remarks,
  required String sample,
}) {
  return Card(
    child: Row(
      children: [
        Image.network(imageUrl),
        Column(
          children: [
            Text('Sample:'),
            Text('Health:'),
            Text('Remarks:'),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              Text(sample),
              Text('$health%'),
              Text(remarks),
            ],
          ),
        ),
      ],
    ),
  );
}
