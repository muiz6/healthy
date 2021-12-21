import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/widgets/my_list_tile.dart';
import 'package:healthy/strings.dart' as strings;

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.products),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (_, index) => Padding(
          padding: const EdgeInsets.all(dimens.insetM),
          child: MyListTile(
            imageAssetName: 'assets/img/product.jpg',
            title: 'Product ${index + 1}',
          ),
        ),
        padding: EdgeInsets.all(dimens.insetM),
      ),
    );
  }
}
