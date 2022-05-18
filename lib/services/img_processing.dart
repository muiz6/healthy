import 'dart:io';

import 'package:dio/dio.dart';

import 'package:healthy/secrets.dart' as secrets;

const _baseUrl = 'https://api.everypixel.com/v1/faces';

final _dio = Dio(BaseOptions(
  connectTimeout: 5000,
  receiveTimeout: 10000,
  headers: {
    'Authorization': secrets.everyPixelAuth,
  },
  receiveDataWhenStatusError: true,
));

Future<Map<String, dynamic>> postFace2(File imageFile) async {
  final response = await _dio.post(
    'https://www.betafaceapi.com/api/v2/media/file',
    data: FormData.fromMap({
      'api_key': secrets.betafaceApiKey,
      'file': MultipartFile.fromBytes(
        await imageFile.readAsBytes(),
        filename: imageFile.uri.pathSegments.last,
      ),
    }),
  );
  return response.data;
}
