import 'package:flutter/material.dart';

import 'package:healthy/widgets/result_page.dart';

class ResultHairPage extends StatelessWidget {
  final Map<String, dynamic> result;

  ResultHairPage(this.result);

  @override
  Widget build(BuildContext context) {
    return ResultPage(
      title: 'Hair Health Score',
      type: 'hair',
      result: result,
    );
  }
}
