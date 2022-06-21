import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/widgets/remedy_tile.dart';
import 'package:healthy/services/repository.dart' as repository;

class RemedyPage extends StatelessWidget {
  final String tag;

  RemedyPage(this.tag);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.homeRemedies),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: repository.getHomeRemedies(tag),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final homeRemedies = snapshot.data!;
            return ListView.builder(
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
                    link: 'https://www.google.com',
                  ),
                );
              },
              padding: EdgeInsets.only(bottom: 16),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
