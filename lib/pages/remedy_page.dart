import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/widgets/remedy_tile.dart';

class RemedyPage extends StatelessWidget {
  final List<dynamic> homeRemedies;

  RemedyPage(this.homeRemedies);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.homeRemedies),
      ),
      body: ListView.builder(
        itemCount: homeRemedies.length,
        itemBuilder: (_, index) {
          final Map<String, dynamic> remedy = homeRemedies[index];
          return Padding(
            padding: const EdgeInsets.all(dimens.insetM),
            child: RemedyTile(
              imageUrl: remedy['imageUrl'],
              title: remedy['name'],
              description: remedy['description'],
              ingredients: remedy['ingredients'].split(','),
            ),
          );
        },
        padding: EdgeInsets.only(bottom: 16),
      ),
    );
  }
}
