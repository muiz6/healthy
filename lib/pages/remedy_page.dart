import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/widgets/remedy_tile.dart';

class RemedyPage extends StatelessWidget {
  final homeRemedies;

  RemedyPage(this.homeRemedies);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.homeRemedies),
      ),
      // body: ListView.builder(
      //   itemCount: homeRemedies.length,
      //   itemBuilder: (_, index) => Padding(
      //     padding: const EdgeInsets.all(dimens.insetM),
      //     child: MyListTile(
      //       imageUrl: homeRemedies[index]['imageUrl'],
      //       title: homeRemedies[index]['name'],
      //     ),
      //   ),
      //   padding: EdgeInsets.all(dimens.insetM),
      // ),
      body: ListView(
        children: [
          RemedyTile(
            imageUrl:
                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.iconsdb.com%2Flight-gray-icons%2Fsquare-icon.html&psig=AOvVaw3tcGHtOho1leTeCwnqG3Df&ust=1653041158471000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCIDY5cSo6_cCFQAAAAAdAAAAABAI',
            title: 'Title',
          ),
          RemedyTile(
            imageUrl:
                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.iconsdb.com%2Flight-gray-icons%2Fsquare-icon.html&psig=AOvVaw3tcGHtOho1leTeCwnqG3Df&ust=1653041158471000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCIDY5cSo6_cCFQAAAAAdAAAAABAI',
            title: 'Title',
          ),
        ],
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
