import 'dart:io';

import 'package:dio/dio.dart';

const _baseUrl = 'https://api.everypixel.com/v1/faces';

final _dio = Dio(BaseOptions(
  connectTimeout: 5000,
  receiveTimeout: 5000,
  headers: {
    'Authorization':
        'Basic dXR3Y3lpUHFwRTM3WFIyb2hrY1YwOGFPOlZxVU5UWU5mZHEzRHpZUDRtdm9ieWJhbDNjV3FTajJsNTJFT0R4cW0zNzNMeEdmUQ==',
  },
  receiveDataWhenStatusError: true,
));

Future<Map<String, dynamic>> postFace(File imageFile) async {
  final response = await _dio.post(
    _baseUrl,
    data: FormData.fromMap({
      'data': MultipartFile.fromBytes(
        await imageFile.readAsBytes(),
        filename: imageFile.uri.pathSegments.last,
      ),
    }),
  );
  return response.data;
}
