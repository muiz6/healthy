import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/pages/product_page.dart';
import 'package:healthy/pages/remedy_page.dart';
import 'package:healthy/pages/view_report_page.dart';
import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/widgets/view_more_tile.dart';

class ResultPage extends StatelessWidget {
  final String type;
  final File image;
  final String title;

  ResultPage({required this.type, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(strings.results)),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchResult(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final report = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(dimens.insetL),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: textTheme.headline4,
                    ),
                    Text(
                      report['health'].toStringAsFixed(2),
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
                      report['remarks'] ?? 'n/a',
                      style: textTheme.headline3?.copyWith(
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      height: dimens.insetM,
                    ),
                    ViewMoreTile(
                      imageAssetName: 'assets/img/product.jpg',
                      title: 'Products',
                      subtitle: 'Natural products for better health',
                      onClick: () => Get.to(ProductPage(report['products'])),
                    ),
                    SizedBox(
                      height: dimens.insetM,
                    ),
                    ViewMoreTile(
                      imageAssetName: 'assets/img/plant.jpg',
                      title: 'Home Remedies',
                      subtitle: 'For the DIY enthusiasts',
                      onClick: () => Get.to(RemedyPage(report['homeRemedies'])),
                    ),
                    SizedBox(
                      height: dimens.insetM,
                    ),
                    ViewMoreTile(
                      imageAssetName: 'assets/img/person.jpg',
                      title: 'Dermatologies',
                      subtitle: 'Need expert advice?',
                    ),
                    SizedBox(
                      height: dimens.insetL,
                    ),
                    ElevatedButton(
                      onPressed: () => Get.to(() => ViewReportPage(type: type)),
                      child: Text('View Reports'),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchResult() {
    if (type == 'hair') {
      return repository.postReportHair(image);
    }
    if (type == 'skin') {
      return repository.postReportSkin(image);
    }
    return Future.error('Invalid type!');
  }
}
