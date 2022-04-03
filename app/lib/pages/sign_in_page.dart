import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/pages/selection_page.dart';
import 'package:healthy/pages/sign_up_page.dart';
import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/util/validators.dart' as validators;
import 'package:healthy/widgets/scrollable_body.dart';

class SignInPage extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final pwdCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableBody(
        child: Form(
          child: Column(
            children: _buildColumnItems(context),
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          key: formKey,
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
        validator: validators.validateEmail,
      ),
      SizedBox(height: dimens.insetL),
      Row(children: [Text(strings.password)]),
      TextFormField(
        controller: pwdCtrl,
        obscureText: true,
        validator: validators.validatePassword,
      ),
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

  Future<void> _onSignIn(context) async {
    if (formKey.currentState?.validate() ?? false) {
      bool successful = false;
      try {
        final result = await repository.signIn(emailCtrl.text, pwdCtrl.text);
        if (result != null) {
          successful = true;
          Get.offAll(SelectionPage());
          return;
        }
      } catch (e) {}
      if (!successful) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong'),
        ));
      }
    }
  }
}
