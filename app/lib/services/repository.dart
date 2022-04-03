import 'package:healthy/services/api_client.dart' as api_client;
import 'package:healthy/services/shared_pref.dart' as shared_pref;
import 'package:healthy/services/firestore.dart' as firestore;

const getUser = shared_pref.getUser;

Future<Map<String, dynamic>?> signIn(String email, String password) async {
  final user = await firestore.readUser(email);
  if (user != null && user['password'] == password) {
    await shared_pref.saveUser(user);
    return user;
  }
}

Future<Map<String, dynamic>?> signUp(
    String name, String email, String password) async {
  final user = await firestore.createUser(name, email, password);
  await shared_pref.saveUser(user);
  return user;
}

Future<void> signOut() async {
  await shared_pref.clearUser();
}

getReports() async {
  final user = await getUser();
  return api_client.getReports(user?['id']);
}

postReportHair(imageBytes, fileName) async {
  final user = await getUser();
  return api_client.postReportHair(user?['id'], imageBytes, fileName);
}

postReportSkin(imageBytes, fileName) async {
  final user = await getUser();
  return api_client.postReportSkin(user?['id'], imageBytes, fileName);
}
