import 'package:shared_preferences/shared_preferences.dart';

const keyName = 'name';
const keyEmail = 'email';

saveUser(Map<String, dynamic> user) async {
  final sharedPref = await SharedPreferences.getInstance();
  sharedPref.setString(keyName, user['name']!);
  sharedPref.setString(keyEmail, user['email']!);
}

getUser() async {
  final sharedPref = await SharedPreferences.getInstance();
  final email = sharedPref.getString(keyEmail);
  if (email != null) {
    return {
      'name': sharedPref.getString(keyName),
      'email': email,
    };
  }
  return null;
}
