import 'package:healthy/services/api_client.dart' as api_client;
import 'package:healthy/services/shared_pref.dart' as shared_pref;

const getUser = shared_pref.getUser;

signIn(email, password) async {
  final user = await api_client.signIn(email, password);
  await shared_pref.saveUser(user);
  return user;
}

signUp(name, email, password) async {
  final user = await api_client.signUp(name, email, password);
  await shared_pref.saveUser(user);
  return user;
}

signOut() async {
  await shared_pref.clearUser();
}

getReports() async {
  final user = await getUser();
  return api_client.getReports(user['id']);
}

postReportHair(imageBytes, fileName) async {
  final user = await getUser();
  return api_client.postReportHair(user['id'], imageBytes, fileName);
}

postReportSkin(imageBytes, fileName) async {
  final user = await getUser();
  return api_client.postReportSkin(user['id'], imageBytes, fileName);
}
