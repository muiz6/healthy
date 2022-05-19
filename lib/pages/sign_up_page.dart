import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/dimens.dart' as dimens;
import 'package:healthy/pages/selection_page.dart';
import 'package:healthy/pages/sign_in_page.dart';
import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/strings.dart' as strings;
import 'package:healthy/util/validators.dart' as validators;
import 'package:healthy/widgets/scrollable_body.dart';
import 'package:healthy/util.dart' as util;

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final pwdCtrl = TextEditingController();
  final _confirmPwdCtrl = TextEditingController();
  final _dobController = TextEditingController();
  String _gender = 'male';
  DateTime _dob = DateTime.now();
  bool _loading = false;

  @override
  void initState() {
    _dobController.value = TextEditingValue(text: util.formatDate(_dob));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ScrollableBody(
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
      Text(
        strings.createYourAccount,
        style: Theme.of(context).textTheme.headline3,
      ),
      SizedBox(height: 40),
      Row(children: [Text(strings.username)]),
      TextFormField(
        controller: nameCtrl,
        validator: validators.validateName,
      ),
      SizedBox(height: dimens.insetL),
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
        validator: (value) => validators.validateConfirmPassword(
          value,
          _confirmPwdCtrl,
        ),
      ),
      SizedBox(height: dimens.insetL),
      Row(children: [Text('Confirm Password')]),
      TextFormField(
        controller: _confirmPwdCtrl,
        obscureText: true,
        validator: (value) => validators.validateConfirmPassword(
          value,
          pwdCtrl,
        ),
      ),
      SizedBox(height: dimens.insetL),
      Row(children: [Text('Date Of Birth')]),
      TextFormField(
        controller: _dobController,
        readOnly: true,
        onTap: () => _onPickDate(context),
      ),
      SizedBox(height: dimens.insetL),
      Row(children: [Text('Gender')]),
      Row(
        children: [
          Radio(
            value: 'male',
            groupValue: _gender,
            onChanged: (String? value) => setState(() => _gender = value!),
          ),
          Expanded(child: Text('Male')),
          Radio(
            value: 'female',
            groupValue: _gender,
            onChanged: (String? value) => setState(() => _gender = value!),
          ),
          Expanded(child: Text('Female')),
        ],
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

  Future<void> _onSignUp(context) async {
    if (formKey.currentState?.validate() ?? false) {
      bool successful = false;
      try {
        setState(() => _loading = true);
        final result = await repository.signUp({
          'name': nameCtrl.text,
          'email': emailCtrl.text,
          'password': pwdCtrl.text,
          'gender': _gender,
          'dob': _dob.millisecondsSinceEpoch,
        });
        if (result != null) {
          successful = true;
          Get.offAll(SelectionPage());
        }
      } catch (e) {}
      if (!successful) {
        await Future.delayed(Duration(seconds: 1));
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong'),
        ));
      }
    }
  }

  Future<void> _onPickDate(BuildContext context) async {
    final date = await util.showMyDatePicker(context, _dob);
    if (date != null) {
      _dob = date;
      _dobController.value = TextEditingValue(text: util.formatDate(_dob));
    }
  }
}
