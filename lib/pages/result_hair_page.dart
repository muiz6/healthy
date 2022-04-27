import 'dart:io';

import 'package:flutter/material.dart';

import 'package:healthy/widgets/result_page.dart';

class ResultHairPage extends StatelessWidget {
  final File image;

  ResultHairPage(this.image);

  @override
  Widget build(BuildContext context) {
    return ResultPage(
      title: 'Hair Health Score',
      type: 'hair',
      image: image,
    );
  }
}
