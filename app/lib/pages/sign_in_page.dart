import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/pages/selection_page.dart';
import 'package:healthy/pages/sign_up_page.dart';
import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/widgets/scrollable_body.dart';

class SignInPage extends StatelessWidget {
  final emailCtrl = TextEditingController();
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
      Text(strings.welcomeBack, style: Theme.of(context).textTheme.headline3),
      SizedBox(height: 40),
      Row(children: [Text(strings.eMail)]),
      TextFormField(
        controller: emailCtrl,
      ),
      SizedBox(height: dimens.insetL),
      Row(children: [Text(strings.password)]),
      TextFormField(controller: pwdCtrl, obscureText: true),
      SizedBox(height: 40),
      _signUpMsg(),
      SizedBox(height: 40),
      Builder(
        builder: (builderContext) => ElevatedButton(
          onPressed: () => _onSignIn(builderContext),
          child: Text(
            strings.signIn,
          ),
        ),
      ),
    ];
  }

  Widget _signUpMsg() {
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

  _onSignIn(context) async {
    var successful = false;
    try {
      final result = await repository.signIn(emailCtrl.text, pwdCtrl.text);
      print(result);
      if (result != null) {
        successful = true;
        Get.offAll(SelectionPage());
      }
    } catch (e) {
      print(e);
    }
    if (!successful) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Something went wrong'),
      ));
    }
  }
}
