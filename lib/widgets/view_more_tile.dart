import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;

class ViewMoreTile extends StatelessWidget {
  String title;
  String subtitle;
  String imageAssetName;
  void Function()? onClick;

  ViewMoreTile({
    required this.title,
    required this.subtitle,
    required this.imageAssetName,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
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
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline3?.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              size: 40,
            ),
          ],
        ),
        padding: EdgeInsets.all(dimens.insetM),
      ),
    );
  }
}
