import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:healthy/pages/result_hair_page.dart';
import 'package:healthy/pages/result_skin_page.dart';

import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/widgets/report_tile.dart';
import 'package:healthy/widgets/result_page.dart';
import 'package:healthy/util.dart' as util;

class ViewReportPage extends StatefulWidget {
  final String? type;

  ViewReportPage({this.type});

  @override
  State<ViewReportPage> createState() => _ViewReportPageState();
}

class _ViewReportPageState extends State<ViewReportPage> {
  List<Map<String, dynamic>>? reports;
  bool deletable = true;

  @override
  void initState() {
    () async {
      reports = await repository.getReports(widget.type);
      setState(() {});
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Reports')),
      body: SafeArea(
        child: reports != null
            ? Column(
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
                  _buildChart(context, reports!),
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
                        final report = reports![index];
                        return Padding(
                          child: ReportTile(
                            imageUrl: report['imageUrl'],
                            health: 0,
                            remarks: report['remarks'] ?? 'n/a',
                            sample: report['type'],
                            deletable: deletable,
                            onDelete: () =>
                                onDeleteReport(context, report['id']),
                            onClick: () => onClickReport(report),
                          ),
                          padding: EdgeInsets.all(8),
                        );
                      },
                      itemCount: reports?.length,
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildChart(BuildContext context, List<Map<String, dynamic>> reports) {
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
                .take(10)
                .toList()
                .reversed
                .toList()
                .asMap()
                .entries
                .map((entry) => FlSpot(
                      entry.key.toDouble(),
                      0,
                    ))
                .toList(),
            isCurved: true,
            colors: gradientColors,
            barWidth: 5,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ],
      )),
    );
  }

  Future<void> onDeleteReport(BuildContext context, String id) async {
    try {
      setState(() => deletable = false);
      final confirmed = await util.showYesNoDialog(
          context, 'Do you want to delete this report?');
      if (confirmed ?? false) {
        await repository.deleteReport(id);
        setState(() => reports = null);
        reports = await repository.getReports(widget.type);
      }
      setState(() => deletable = true);
    } catch (e) {}
  }

  void onClickReport(Map<String, dynamic> report) {
    if (report['type'] == 'hair') {
      Get.to(() => ResultHairPage(report));
    } else if (report['type'] == 'skin') {
      Get.to(() => ResultSkinPage(report));
    }
  }
}
