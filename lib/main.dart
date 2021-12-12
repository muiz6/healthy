import 'package:flutter/material.dart';

import 'package:healthy/strings.dart' as strings;
import 'package:healthy/pages/sign_up.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: strings.appName,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SignUpPage(),
    );
  }
}
