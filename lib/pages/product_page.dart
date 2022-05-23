import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/widgets/product_tile.dart';

class ProductPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.products),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final p = products[index];
          return Padding(
            child: ProductTile(
              imageUrl: p['imageUrl'],
              title: p['name'],
              link: p['link'],
            ),
            padding: EdgeInsets.only(bottom: 16),
          );
        },
        itemCount: products.length,
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
