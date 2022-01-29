import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/pages/sign_in_page.dart';
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/widgets/scrollable_body.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableBody(
        child: Column(
          children: _buildColumnItems(context),
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }

  List<Widget> _buildColumnItems(BuildContext context) {
    return [
      Text(
        strings.createYourAccount,
        style: Theme.of(context).textTheme.headline3,
      ),
      SizedBox(height: 40),
      Row(children: [Text(strings.username)]),
      TextFormField(),
      SizedBox(height: dimens.insetL),
      Row(children: [Text(strings.eMail)]),
      TextFormField(),
      SizedBox(height: dimens.insetL),
      Row(children: [Text(strings.password)]),
      TextFormField(obscureText: true),
      SizedBox(height: 40),
      _signInMsg(),
      SizedBox(height: 40),
      ElevatedButton(onPressed: () {}, child: Text('Sign Up')),
    ];
  }

  Widget _signInMsg() {
    return Row(
      children: [
        Text(strings.haveAnAccount),
        TextButton(
          onPressed: () => Get.offAll(SignInPage()),
          child: Text(strings.signIn),
        ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
