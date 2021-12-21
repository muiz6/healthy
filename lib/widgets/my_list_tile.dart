import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  String title;

  MyListTile({
    // required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/plant.jpg'),
              ),
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
