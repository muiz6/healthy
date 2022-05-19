import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:healthy/pages/confirm_password_page.dart';
import 'package:healthy/services/repository.dart' as repository;
import 'package:healthy/util.dart' as util;
import 'package:healthy/util/validators.dart' as validators;

class ProfilePage extends StatefulWidget {
  ProfilePage();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameCtrl = TextEditingController();
  final _dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? _user;
  DateTime _dob = DateTime.now();
  bool _disabled = false;

  @override
  void initState() {
    () async {
      _user = await repository.getUser();
      _nameCtrl.value = TextEditingValue(text: _user?['name']);
      _dob = DateTime.fromMillisecondsSinceEpoch(_user?['dob']);
      _dobController.value = TextEditingValue(text: util.formatDate(_dob));
      setState(() {});
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: _user != null
          ? Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 14),
                      Center(
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 120,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(height: 50),
                      Form(
                        child: TextFormField(
                          controller: _nameCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Name'),
                          ),
                          validator: (v) => validators.validateName(v),
                        ),
                        key: _formKey,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: _dobController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Date Of Birth'),
                        ),
                        readOnly: true,
                        onTap: () => _onPickDate(context),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        child: Text('Change Password'),
                        onPressed: () => Get.to(() => ConfirmPasswordPage()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                    padding: EdgeInsets.all(16),
                  ),
                ),
                Padding(
                  child: ElevatedButton(
                    child: Text('Save Changes'),
                    onPressed: _disabled ? null : () => _onSave(context),
                  ),
                  padding: EdgeInsets.all(16),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
            )
          : SizedBox(),
    );
  }

  Future<void> _onPickDate(BuildContext context) async {
    final date = await util.showMyDatePicker(context, _dob);
    if (date != null) {
      _dob = date;
      _dobController.value = TextEditingValue(text: util.formatDate(_dob));
    }
  }

  void _onSave(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _disabled = true);
      try {
        _user!['name'] = _nameCtrl.value.text;
        _user!['dob'] = _dob.millisecondsSinceEpoch;
        await repository.updateUser(_user!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Profile updated successfully'),
        ));
        await Future.delayed(Duration(seconds: 2));
      } catch (e) {}
      setState(() => _disabled = false);
    }
  }
}
