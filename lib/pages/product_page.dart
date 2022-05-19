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
        children: [
          ProductTile(
            imageUrl:
                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.iconsdb.com%2Flight-gray-icons%2Fsquare-icon.html&psig=AOvVaw3tcGHtOho1leTeCwnqG3Df&ust=1653041158471000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCIDY5cSo6_cCFQAAAAAdAAAAABAI',
            title: 'Title',
          ),
          SizedBox(height: 16),
          ProductTile(
            imageUrl:
                'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.andeditions.org%2F%3Fattachment_id%3D199&psig=AOvVaw0TnLhZyttxWouY19Nw42Wc&ust=1653034499186000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCMCJ_sOP6_cCFQAAAAAdAAAAABAa',
            title: 'Title',
          ),
        ],
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
