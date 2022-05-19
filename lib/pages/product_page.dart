import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/widgets/my_list_tile.dart';
import 'package:healthy/strings.dart' as strings;

class ProductPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.products),
      ),
      // body: ListView.builder(
      //   itemCount: products.length,
      //   itemBuilder: (_, index) => Padding(
      //     padding: const EdgeInsets.all(dimens.insetM),
      //     child: MyListTile(
      //       imageUrl: products[index]['imageUrl'],
      //       title: products[index]['name'],
      //     ),
      //   ),
      //   padding: EdgeInsets.all(dimens.insetM),
      // ),
      body: ListView(
        children: [],
      ),
    );
  }
}
