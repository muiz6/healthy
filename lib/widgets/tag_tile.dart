import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy/pages/product_page.dart';
import 'package:healthy/pages/remedy_page.dart';

class TagTile extends StatelessWidget {
  Map<String, dynamic> tag;

  TagTile(this.tag);

  @override
  Widget build(BuildContext context) {
    final stateColor = tag['confidence'] >= 0.5 ? Colors.red : Colors.orange;
    return Column(
      children: [
        Text(
          tag['name'].toUpperCase(),
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 3),
        Row(
          children: [
            Text(
              '${(100 * tag["confidence"]).toInt()}%',
              style: TextStyle(color: stateColor),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 3,
                      color: stateColor,
                    ),
                    flex: (100 * tag['confidence']).toInt(),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: (100 * (1 - tag['confidence'])).toInt(),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(
              child: Text('Products'),
              onPressed: () => Get.to(() => ProductPage(tag['products'] ?? [])),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                )),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              child: Text('Remedies'),
              onPressed: () => Get.to(() => RemedyPage(tag['remedies'] ?? [])),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondary),
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                )),
              ),
            ),
          ],
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
