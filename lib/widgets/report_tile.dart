import 'package:flutter/material.dart';

class ReportTile extends StatelessWidget {
  final String imageUrl;
  final double health;
  final String remarks;
  final String sample;
  final bool deletable;
  final Function()? onDelete;
  final Function()? onClick;

  ReportTile({
    required this.imageUrl,
    required this.health,
    required this.remarks,
    required this.sample,
    this.deletable = true,
    this.onDelete,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
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
                    Text(health.toStringAsFixed(2)),
                    Text(remarks),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: deletable ? Colors.grey : Colors.grey.shade200,
                ),
                onPressed: onDelete,
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
      onTap: onClick,
    );
  }
}
