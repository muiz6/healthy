import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/pages/sign_in_page.dart';
import 'package:healthy/strings.dart' as strings;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: strings.appName,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: SignInPage(),
    );
  }
}
