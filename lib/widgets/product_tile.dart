import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:url_launcher/url_launcher.dart';

class ProductTile extends StatelessWidget {
  String title;
  String imageUrl;
  String link;

  ProductTile({
    required this.imageUrl,
    required this.title,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(dimens.insetM),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              width: dimens.insetM,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text('Lorem ipsum dolor sit amet lorem ipsum dolor sit amet'),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text('Buy'),
                    onPressed: () => launchUrl(
                      Uri.parse(link),
                      mode: LaunchMode.externalApplication,
                    ),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
