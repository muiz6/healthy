import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final firestore = FirebaseFirestore.instance;
final users = firestore.collection('users');
final reports = firestore.collection('reports');
final _products = firestore.collection('products');
final _homeRemedies = firestore.collection('homeRemedies');

Future<Map<String, dynamic>> createUser(Map<String, dynamic> user) async {
  final snapshot = await users.where('email', isEqualTo: user['email']).get();
  if (snapshot.docs.isEmpty) {
    await users.add(user);
    return user;
  }
  throw (ArgumentError('User ${user["email"]}: already exists!'));
}

Future<Map<String, dynamic>?> readUser(email) async {
  final snapshot = await users.where('email', isEqualTo: email).get();
  if (snapshot.docs.isNotEmpty) {
    return snapshot.docs.first.data();
  }
}

Future<void> updateUser(Map<String, dynamic> user) async {
  final snapshot = await users.where('email', isEqualTo: user['email']).get();
  final userDoc = snapshot.docs.first;
  await userDoc.reference.update(user);
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

Future<List<Map<String, dynamic>>> readReports(
    String userEmail, String? type) async {
  Query<Map<String, dynamic>> query =
      reports.where('userEmail', isEqualTo: userEmail);
  if (type != null && type.isNotEmpty) {
    query = query.where('type', isEqualTo: type);
  }
  query = query.orderBy('createdAt', descending: true);
  final snapshot = await query.get();
  return snapshot.docs.map((document) => document.data()).toList();
}

Future<void> deleteReport(String id) async {
  final snapshot = await reports.where('id', isEqualTo: id).get();
  await snapshot.docs.first.reference.delete();
}

Future<List<Map<String, dynamic>>> readProducts() async {
  final snapshot = await _products.get();
  return snapshot.docs.map((document) => document.data()).toList();
}

Future<List<Map<String, dynamic>>> readHomeRemedies() async {
  final snapshot = await _homeRemedies.get();
  return snapshot.docs.map((document) => document.data()).toList();
}
