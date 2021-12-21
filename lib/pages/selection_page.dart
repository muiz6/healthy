import 'package:flutter/material.dart';
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/dimens.dart' as dimens;

class SelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(dimens.insetL),
        child: Column(
          children: [
            Text(
              strings.msgSelect,
              style: textTheme.headline3,
            ),
            SizedBox(
              height: dimens.insetL,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(dimens.insetL),
                child: Column(
                  children: [
                    Icon(
                      Icons.face,
                      size: 72,
                    ),
                    SizedBox(
                      height: dimens.insetM,
                    ),
                    Text(strings.hair),
                  ],
                ),
              ),
            ),
            SizedBox(height: dimens.insetL),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(dimens.insetL),
                child: Column(
                  children: [
                    Icon(
                      Icons.face_retouching_natural_sharp,
                      size: 72,
                    ),
                    SizedBox(
                      height: dimens.insetM,
                    ),
                    Text(strings.skin),
                  ],
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      ),
    );
  }
}
