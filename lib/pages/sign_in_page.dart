import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/pages/sign_up_page.dart';
import 'package:healthy/strings.dart' as strings;

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            child: Column(
              children: _buildColumnItems(),
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            padding: EdgeInsets.all(dimens.insetL),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildColumnItems() {
    return [
      Text(strings.welcomeBack),
      SizedBox(height: 40),
      Row(children: [Text(strings.eMail)]),
      TextFormField(),
      SizedBox(height: dimens.insetL),
      Row(children: [Text(strings.password)]),
      TextFormField(obscureText: true),
      SizedBox(height: 40),
      _signInMsg(),
      SizedBox(height: 40),
      ElevatedButton(onPressed: () {}, child: Text(strings.signIn)),
    ];
  }

  Widget _signInMsg() {
    return Row(
      children: [
        Text(strings.dontHaveAnAccount),
        TextButton(
          onPressed: () => Get.offAll(SignUpPage()),
          child: Text(strings.signUp),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
