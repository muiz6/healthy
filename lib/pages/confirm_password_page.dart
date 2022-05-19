import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthy/pages/change_password_page.dart';

import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/util/validators.dart' as validators;

class ConfirmPasswordPage extends StatefulWidget {
  ConfirmPasswordPage();

  @override
  State<ConfirmPasswordPage> createState() => _ConfirmPasswordPageState();
}

class _ConfirmPasswordPageState extends State<ConfirmPasswordPage> {
  final _pwdCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _disabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirm Password')),
      body: Builder(
        builder: (buidlerContext) => Form(
          child: ListView(
            children: [
              TextFormField(
                controller: _pwdCtrl,
                decoration: InputDecoration(hintText: 'Enter Password'),
                validator: (v) => validators.validatePassword(v),
                enabled: !_disabled,
                obscureText: true,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Confirm'),
                onPressed: () => _onConfirmPassword(buidlerContext),
              ),
            ],
            padding: EdgeInsets.all(16),
          ),
          key: _formKey,
        ),
      ),
    );
  }

  void _onConfirmPassword(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _disabled = true);
      final user = await repository.getUser();
      if (_pwdCtrl.value.text == user!['password']) {
        Get.off(() => ChangePasswordPage());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Incorrect password!'),
        ));
        await Future.delayed(Duration(seconds: 1));
        setState(() => _disabled = false);
      }
    }
  }
}
