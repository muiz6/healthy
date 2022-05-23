import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/pages/product_page.dart';
import 'package:healthy/pages/remedy_page.dart';
import 'package:healthy/pages/view_report_page.dart';
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/widgets/tag_tile.dart';
import 'package:healthy/widgets/view_more_tile.dart';
import 'package:healthy/util.dart' as util;

class ResultPage extends StatelessWidget {
  final String type;
  final Map<String, dynamic> result;
  final String title;
  final List<String> tags;

  ResultPage({
    required this.type,
    required this.result,
    required this.title,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(strings.results)),
      body: ListView(
        children: [
          Text(util.formatDate(DateTime.now())),
          SizedBox(height: 8),
          Text(
            title,
            style: textTheme.headline4,
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Text(
                '${result['health']?.toInt()}',
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: _remarkColor(result['health']),
                    ),
              ),
              SizedBox(width: 8),
              Text('out of 100'),
              SizedBox(width: 10),
              Container(
                child: Text(
                  _remarks(result['health']),
                  style: TextStyle(
                    color: _remarkColor(result['health']),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                decoration: BoxDecoration(
                  color: _remarkColor(result['health']).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.all(8),
              ),
            ],
          ),
          SizedBox(
            height: dimens.insetM,
          ),
          ...symptoms(),
          SizedBox(
            height: dimens.insetM,
          ),
          InkWell(
            child: ViewMoreTile(
              imageAssetName: 'assets/img/person.jpg',
              title: 'Dermatologists',
              subtitle: 'You need dermatologist for better treatment',
            ),
            onTap: () => launchUrl(
              Uri.parse(
                  'https://www.google.com/search?q=dermatologists+near+me'),
              mode: LaunchMode.externalApplication,
            ),
          ),
          SizedBox(
            height: dimens.insetL,
          ),
          ElevatedButton(
            onPressed: () => Get.to(() => ViewReportPage(type: type)),
            child: Text('View Reports'),
          ),
        ],
        padding: EdgeInsets.all(16),
      ),
    );
  }

  List<Widget> symptoms() {
    final List reportTags = result['report']['media']['faces'][0]['tags'];
    return reportTags
        .where((t) => tags.contains(t['name']) && t['value'] == 'yes')
        .map((t) => Padding(
              child: TagTile(t),
              padding: const EdgeInsets.only(bottom: 8.0),
            ))
        .toList();
  }

  String _remarks(double score) {
    if (score < 50) {
      return 'Bad';
    }
    if (score < 80) {
      return 'Good';
    }
    return 'Very Good';
  }

  Color _remarkColor(double score) {
    if (score < 50) {
      return Colors.red;
    }
    if (score < 80) {
      return Colors.orange;
    }
    return Colors.green;
  }
}
