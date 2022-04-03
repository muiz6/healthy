import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = FirebaseFirestore.instance;
final users = firestore.collection('users');

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
