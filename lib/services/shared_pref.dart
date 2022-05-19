import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const keyUser = 'user';

Future<void> saveUser(Map<String, dynamic> user) async {
  final sharedPref = await SharedPreferences.getInstance();
  sharedPref.setString(keyUser, jsonEncode(user));
}

Future<Map<String, dynamic>?> getUser() async {
  final sharedPref = await SharedPreferences.getInstance();
  final user = sharedPref.getString(keyUser);
  if (user != null) {
    return jsonDecode(user);
  }
  return null;
}

Future<void> clearUser() async {
  final sharedPref = await SharedPreferences.getInstance();
  await sharedPref.remove(keyUser);
}
