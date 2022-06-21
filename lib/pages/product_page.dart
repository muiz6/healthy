import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/services/firestore.dart';
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/widgets/product_tile.dart';
import 'package:healthy/services/repository.dart' as repository;

class ProductPage extends StatelessWidget {
  final String tag;

  ProductPage(this.tag);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.products),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: repository.getProducts(tag),
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                final p = products[index];
                return Padding(
                  child: ProductTile(
                    description:
                        'Lorem ipsum dolor sit amet lorem ipsum dolor sit amet',
                    imageUrl: p['imageUrl'],
                    title: p['name'],
                    link: p['link'],
                  ),
                  padding: EdgeInsets.only(bottom: 16),
                );
              },
              itemCount: products.length,
              padding: EdgeInsets.all(16),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
