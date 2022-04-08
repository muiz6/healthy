import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';

import 'package:healthy/secrets.dart' as secrets;

const _baseUrl = 'https://api.everypixel.com/v1/faces';

final _dio = Dio(BaseOptions(
  connectTimeout: 5000,
  receiveTimeout: 5000,
  headers: {
    'Authorization': secrets.everyPixelAuth,
  },
  receiveDataWhenStatusError: true,
));

Future<double> postFace(File imageFile) async {
  final response = await _dio.post(
    _baseUrl,
    data: FormData.fromMap({
      'data': MultipartFile.fromBytes(
        await imageFile.readAsBytes(),
        filename: imageFile.uri.pathSegments.last,
      ),
    }),
  );
  final face = response.data['faces'][0];
  if (face != null) {
    return 1 / max<double>(face['age'] - 12, 1);
  }
  throw (Exception('No face detected!'));
}
