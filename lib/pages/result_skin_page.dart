import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthy/widgets/result_page.dart';

class ResultSkinPage extends StatelessWidget {
  final File image;

  ResultSkinPage(this.image);

  @override
  Widget build(BuildContext context) {
    return ResultPage(
      type: 'skin',
      image: image,
      title: 'Skin Health Score',
    );
  }
}
