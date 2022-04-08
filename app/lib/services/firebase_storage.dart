import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();
final _imageRef = FirebaseStorage.instance.ref().child('images');

Future<String> uploadImage(File file) async {
  final ref = _imageRef.child('${_uuid.v1()}/${file.uri.pathSegments.last}');
  await ref.putFile(file);
  return ref.getDownloadURL();
}
