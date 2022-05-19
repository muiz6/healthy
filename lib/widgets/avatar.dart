import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          child: IconButton(
            icon: Card(
              child: Padding(
                child: Icon(Icons.edit),
                padding: EdgeInsets.all(3),
              ),
              shape: CircleBorder(),
            ),
            onPressed: () {},
          ),
          bottom: -10,
          right: -10,
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
