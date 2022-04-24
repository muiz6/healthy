import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;

class ScrollableBody extends StatelessWidget {
  final Widget child;

  ScrollableBody({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (_, constraints) => SingleChildScrollView(
          child: Container(
            child: child,
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
          ),
          padding: EdgeInsets.all(dimens.insetL),
        ),
      ),
    );
  }
}
