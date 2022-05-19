import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/pages/product_page.dart';
import 'package:healthy/pages/remedy_page.dart';
import 'package:healthy/pages/view_report_page.dart';
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/widgets/tag_tile.dart';
import 'package:healthy/widgets/view_more_tile.dart';

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
          Text(
            title,
            style: textTheme.headline4,
          ),
          Text(
            '0',
            style: TextStyle(
              fontSize: 100,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            strings.remarks,
            style: textTheme.headline4,
          ),
          Text(
            result['remarks'] ?? 'n/a',
            style: textTheme.headline3?.copyWith(
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: dimens.insetM,
          ),
          TagTile({
            'name': 'bags under eyes',
            'value': 'yes',
            'confidence': 0.7,
          }),
          SizedBox(height: 20),
          TagTile({
            'name': 'double chin',
            'value': 'yes',
            'confidence': 0.4,
          }),
          ...s(),
          SizedBox(
            height: dimens.insetM,
          ),
          ViewMoreTile(
            imageAssetName: 'assets/img/person.jpg',
            title: 'Dermatologists',
            subtitle: 'You need dermatologist for better treatment',
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

  List<Widget> s() {
    final List reportTags = result['report']['media']['faces'][0]['tags'];
    return tags.map((t) {
      Map<String, dynamic> tag = reportTags.firstWhere((rt) => rt['name'] == t);
      if (tag['value'] == 'yes') {
        TagTile(tag);
      }
      return SizedBox();
    }).toList();
  }
}
