import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/widgets/my_list_tile.dart';
import 'package:healthy/strings.dart' as strings;

class RemedyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.homeRemedies),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(dimens.insetM),
          child: MyListTile(
            imageAssetName: 'assets/img/plant.jpg',
            title: 'Home Remedy ${index + 1}',
          ),
        ),
        padding: EdgeInsets.all(dimens.insetM),
      ),
    );
  }
}
