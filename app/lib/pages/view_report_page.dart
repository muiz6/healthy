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
              itemBuilder: (_, index) {
                final report = data['reports'][index];
                return ReportTile(
                  // imageUrl: '${data['base_image_url']}${report['image_url']}',
                  imageUrl: 'http://192.168.18.8/images/${report['image_url']}',
                  health: report['health'],
                  remarks: report['remarks'],
                  sample: report['sample'],
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
