import 'package:flutter/material.dart';

ReportTile({
  required String imageUrl,
  required int health,
  required String remarks,
  required String sample,
}) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            child: Image.network(
              imageUrl,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          SizedBox(width: 16),
          Column(
            children: [
              Text('Sample:'),
              Text('Health:'),
              Text('Remarks:'),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Text(sample),
                Text('$health%'),
                Text(remarks),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ],
      ),
    ),
  );
}
