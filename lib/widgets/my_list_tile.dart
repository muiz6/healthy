import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;

class MyListTile extends StatelessWidget {
  String title;
  String imageUrl;

  MyListTile({
    required this.imageUrl,
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
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
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
