import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:url_launcher/url_launcher.dart';

class RemedyTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final List<String> ingredients;

  RemedyTile({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.ingredients,
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
                  SizedBox(height: 3),
                  Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Column(
                    children: [
                      ...ingredients.map((i) => Row(
                            children: [
                              Padding(
                                child: Icon(Icons.circle, size: 8),
                                padding: EdgeInsets.only(top: 5),
                              ),
                              SizedBox(width: 3),
                              Expanded(child: Text(i)),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          )),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Text(description),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text('View'),
                    onPressed: () {},
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.stretch,
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
