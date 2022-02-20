import 'package:shared_preferences/shared_preferences.dart';

const keyUserId = 'userId';
const keyName = 'name';
const keyEmail = 'email';

saveUser(user) async {
  final sharedPref = await SharedPreferences.getInstance();
  sharedPref.setInt(keyUserId, user['id']);
  sharedPref.setString(keyName, user['name']!);
  sharedPref.setString(keyEmail, user['email']!);
}

getUser() async {
  final sharedPref = await SharedPreferences.getInstance();
  final email = sharedPref.getString(keyEmail);
  if (email != null) {
    return {
      'id': sharedPref.getInt(keyUserId),
      'name': sharedPref.getString(keyName),
      'email': email,
    };
  }
  return null;
}

clearUser() async {
  final sharedPref = await SharedPreferences.getInstance();
  await sharedPref.remove(keyEmail);
  await sharedPref.remove(keyName);
}
