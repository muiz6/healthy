import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy/pages/view_report_page.dart';

class SelectReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Report')),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: [
          ...[
            {
              'image': 'assets/img/hair.jpg',
              'title': 'Hair',
              'onTap': () => Get.to(() => ViewReportPage(type: 'hair')),
            },
            {
              'image': 'assets/img/skin.jpg',
              'title': 'Skin',
              'onTap': () => Get.to(() => ViewReportPage(type: 'skin')),
            },
            {
              'image': 'assets/img/head.jpg',
              'title': 'Both',
              'onTap': () => Get.to(() => ViewReportPage()),
            },
          ].map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            child: CircleAvatar(
                              backgroundImage: AssetImage(e['image'] as String),
                            ),
                            height: 70,
                            width: 70,
                          ),
                          SizedBox(width: 16),
                          Text(e['title'] as String)
                        ],
                      ),
                    ),
                  ),
                  onTap: e['onTap'] as Function(),
                ),
              )),
        ],
      ),
    );
  }
}
