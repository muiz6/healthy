import 'dart:io';
import 'dart:math';

import 'package:healthy/services/api_client.dart' as api_client;
import 'package:healthy/services/shared_pref.dart' as shared_pref;
import 'package:healthy/services/firestore.dart' as firestore;
import 'package:healthy/services/firebase_storage.dart' as fb_storage;
import 'package:healthy/services/img_processing.dart' as img_processing;

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

Future<Map<String, dynamic>> postReportHair(File imageFile) {
  return postReport(imageFile, 'hair');
}

Future<Map<String, dynamic>> postReportSkin(File imageFile) {
  return postReport(imageFile, 'skin');
}

Future<Map<String, dynamic>> postReport(File imageFile, String type) async {
  final user = await getUser();
  final downloadUrl = await fb_storage.uploadImage(imageFile);
  final health = await img_processing.postFace(imageFile);
  return firestore.createReport({
    'userEmail': user?['email'],
    'imageUrl': downloadUrl,
    'type': type,
    'health': health,
  });
}
