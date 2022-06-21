import 'dart:io';
import 'dart:math';

import 'package:healthy/services/shared_pref.dart' as shared_pref;
import 'package:healthy/services/firestore.dart' as firestore;
import 'package:healthy/services/firebase_storage.dart' as fb_storage;
import 'package:healthy/services/img_processing.dart' as img_processing;

const getUser = shared_pref.getUser;
const deleteReport = firestore.deleteReport;
const getProducts = firestore.readProducts;
const getHomeRemedies = firestore.readHomeRemedies;

Future<Map<String, dynamic>?> signIn(String email, String password) async {
  final user = await firestore.readUser(email);
  if (user != null && user['password'] == password) {
    await shared_pref.saveUser(user);
    return user;
  }
}

Future<Map<String, dynamic>?> signUp(Map<String, dynamic> user) async {
  final signedUser = await firestore.createUser(user);
  await shared_pref.saveUser(signedUser);
  return user;
}

Future<void> signOut() async {
  await shared_pref.clearUser();
}

Future<List<Map<String, dynamic>>> getReports(String? type) async {
  final user = await getUser();
  final reports = await firestore.readReports(user!['email'], type);
  reports.forEach((r) async => r.addAll({'health': await _getHealthScore(r)}));
  return reports;
}

Future<Map<String, dynamic>> postReportHair(File imageFile) {
  return postReport(imageFile, 'hair');
}

Future<Map<String, dynamic>> postReportSkin(File imageFile) {
  return postReport(imageFile, 'skin');
}

Future<Map<String, dynamic>> postReport(File imageFile, String type) async {
  final user = await getUser();

  final processedReport = await img_processing.postFace2(imageFile);
  if (processedReport['media']['faces'] != null) {
    final downloadUrl = await fb_storage.uploadImage(imageFile);
    final report = {
      'userEmail': user!['email'],
      'imageUrl': downloadUrl,
      'type': type,
      'report': processedReport,
    };
    await _processReports([report]);
    await firestore.createReport(report);
    return report;
  }
  throw FormatException('No face detected!');
}

Future<void> updateUser(Map<String, dynamic> user) async {
  await firestore.updateUser(user);
  await shared_pref.saveUser(user);
}

Future<double> _getHealthScore(Map<String, dynamic> report) async {
  final user = (await getUser())!;
  final age = DateTime.now().year -
      DateTime.fromMillisecondsSinceEpoch(user['dob']).year;
  final tags = report['report']['media']['faces'][0]['tags'];
  final predictedAge =
      int.parse(tags.firstWhere((t) => t['name'] == 'age')['value']);
  double health = age / predictedAge * 100;
  if (health >= 100) {
    health = 99;
  }
  return health;
}

Future<void> _processReports(List<Map<String, dynamic>> reports) async {
  final products = await firestore.readProducts('');
  final remedies = await firestore.readHomeRemedies('');

  for (int i = 0; i < reports.length; i++) {
    final r = reports[i];
    r.addAll({'health': await _getHealthScore(r)});
    final tags = r['report']['media']['faces'][0]['tags'];
    final target = [
      'bags under eyes',
      'double chin',
      'pale skin',
      'receding hairline',
      'bald',
      'gray hair',
    ];
    tags
        .where((t) => target.contains(t['name']) && t['value'] == 'yes')
        .forEach((t) {
      final relevantProducts =
          products.where((p) => p['category'] == t['name']).toList();
      final relevantRemedies =
          remedies.where((r) => r['category'] == t['name']).toList();
      t.addAll({
        'products': relevantProducts.take(2).toList(),
        'remedies': relevantRemedies.take(2).toList(),
      });
    });
  }
}
