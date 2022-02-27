import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/widgets/report_tile.dart';

ViewReportPage() {
  return Scaffold(
    appBar: AppBar(title: Text('Your Reports')),
    body: SafeArea(
      child: FutureBuilder<dynamic>(
        future: repository.getReports(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Your Health Trend',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ],
                ),
                _buildChart(context, data['reports']),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Your Reports',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemBuilder: (_, index) {
                      final report = data['reports'][index];
                      return Padding(
                        child: ReportTile(
                          imageUrl: report['image_url'],
                          health: report['health'],
                          remarks: report['remarks'],
                          sample: report['sample'],
                        ),
                        padding: EdgeInsets.all(8),
                      );
                    },
                    itemCount: data['reports'].length,
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    ),
  );
}

_buildChart(BuildContext context, List<dynamic> reports) {
  final colorScheme = Theme.of(context).colorScheme;
  List<Color> gradientColors = [
    colorScheme.primaryVariant,
    colorScheme.primary
  ];
  return Container(
    padding: EdgeInsets.only(left: 8, top: 16, right: 32, bottom: 32),
    height: 200,
    child: LineChart(LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false, getTitles: (t) => '$t%'),
        topTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(left: BorderSide(), bottom: BorderSide()),
      ),
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: reports
              .asMap()
              .entries
              .map((entry) => FlSpot(
                    entry.key.toDouble(),
                    entry.value['health'].toDouble(),
                  ))
              .toList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    )),
  );
}
