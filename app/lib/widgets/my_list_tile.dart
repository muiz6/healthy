import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;

class MyListTile extends StatelessWidget {
  String title;
  String imageAssetName;

  MyListTile({
    required this.imageAssetName,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(dimens.insetM),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageAssetName),
                ),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: dimens.insetM,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
