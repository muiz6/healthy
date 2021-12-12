import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/pages/sign_in_page.dart';
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/theme.dart' as theme;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: strings.appName,
      theme: theme.appTheme,
      home: SignInPage(),
    );
  }
}
