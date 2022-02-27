import 'package:flutter/material.dart';

import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/widgets/report_tile.dart';

ViewReportPage() {
  return Scaffold(
    appBar: AppBar(
      title: Text('Your Reports'),
    ),
    body: SafeArea(
      child: FutureBuilder<dynamic>(
        future: repository.getReports(),
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
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
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ),
  );
}
