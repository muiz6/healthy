import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/util/validators.dart' as validators;
import 'package:healthy/services/repository.dart' as repository;

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _pwdCtrl = TextEditingController();
  final _rePwdCtrl = TextEditingController();
  bool _disabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: Builder(
        builder: (builderContext) => Form(
          child: ListView(
            children: [
              TextFormField(
                controller: _pwdCtrl,
                decoration: InputDecoration(hintText: 'Enter new password'),
                validator: (v) => validators.validatePassword(v),
                enabled: !_disabled,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _rePwdCtrl,
                decoration: InputDecoration(hintText: 'Re-enter password'),
                validator: (v) =>
                    validators.validateConfirmPassword(v, _pwdCtrl),
                enabled: !_disabled,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Confirm'),
                onPressed: () => _onChangePassword(builderContext),
              ),
            ],
            padding: EdgeInsets.all(16),
          ),
          key: _formKey,
        ),
      ),
    );
  }

  void _onChangePassword(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _disabled = true);
      final user = await repository.getUser();
      user!['password'] = _rePwdCtrl.value.text;
      await repository.updateUser(user);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password updated successfully'),
      ));
      await Future.delayed(Duration(seconds: 1));
      Get.back();
    }
  }
}
