import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/pages/splash_page.dart';
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/theme.dart' as theme;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: strings.appName,
      theme: theme.appTheme,
      home: SplashPage(),
      defaultTransition: Transition.leftToRight,
    );
  }
}
