import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/pages/selection_page.dart';
import 'package:healthy/pages/sign_in_page.dart';
import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/widgets/scrollable_body.dart';

class SignUpPage extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();

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
      TextFormField(controller: nameCtrl),
      SizedBox(height: dimens.insetL),
      Row(children: [Text(strings.eMail)]),
      TextFormField(controller: emailCtrl),
      SizedBox(height: dimens.insetL),
      Row(children: [Text(strings.password)]),
      TextFormField(
        controller: pwdCtrl,
        obscureText: true,
      ),
      SizedBox(height: 40),
      _signInMsg(),
      SizedBox(height: 40),
      Builder(
        builder: (builderContext) => ElevatedButton(
          onPressed: () => _onSignUp(builderContext),
          child: Text(
            strings.signUp,
          ),
        ),
      ),
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

  _onSignUp(context) async {
    var successful = false;
    try {
      final result =
          await repository.signUp(nameCtrl.text, emailCtrl.text, pwdCtrl.text);
      if (result != null) {
        successful = true;
        Get.offAll(SelectionPage());
      }
    } catch (e) {}
    if (!successful) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Something went wrong'),
      ));
    }
  }
}
