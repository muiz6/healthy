import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/pages/selection_page.dart';
import 'package:healthy/pages/sign_in_page.dart';
import 'package:healthy/services/repository.dart' as repository;

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback(_afterBuild);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }

  void _afterBuild(Duration duration) async {
    final user = await repository.getUser();
    if (user != null) {
      return Get.offAll(SelectionPage());
    }
    return Get.offAll(SignInPage());
  }
}
