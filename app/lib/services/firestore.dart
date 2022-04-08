import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final firestore = FirebaseFirestore.instance;
final users = firestore.collection('users');
final reports = firestore.collection('reports');

Future<Map<String, dynamic>> createUser(name, email, password) async {
  final snapshot = await users.where('email', isEqualTo: email).get();
  if (snapshot.docs.isEmpty) {
    final user = {
      'email': email,
      'name': name,
      'password': password,
    };
    await users.add(user);
    return user;
  }
  throw (ArgumentError('User $email: already exists!'));
}

Future<Map<String, dynamic>?> readUser(email) async {
  final snapshot = await users.where('email', isEqualTo: email).get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.data();
  }
}

Future<Map<String, dynamic>> createReport(Map<String, dynamic> report) async {
  report.addAll({
    'id': uuid.v1(),
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
  });
  await reports.add(report);
  return report;
}

Future<List<Map<String, dynamic>>> readReports(String userEmail) async {
  final snapshot = await reports
      .where('userEmail', isEqualTo: userEmail)
      .orderBy('createdAt')
      .get();
  return snapshot.docs.map((document) => document.data()).toList();
}
