import 'package:flutter/material.dart';

import 'package:healthy/widgets/result_page.dart';

class ResultSkinPage extends StatelessWidget {
  final Map<String, dynamic> result;

  ResultSkinPage(this.result);

  @override
  Widget build(BuildContext context) {
    return ResultPage(
      type: 'skin',
      result: result,
      title: 'Skin Health Score',
    );
  }
}
