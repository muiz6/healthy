import 'package:flutter/material.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/strings.dart' as strings;

class SignUpPage extends StatelessWidget {
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
      Text(strings.createYourAccount),
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
        TextButton(onPressed: () {}, child: Text(strings.signIn)),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
