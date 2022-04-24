import 'package:dio/dio.dart';

const _apiUrl = 'http://192.168.18.8/';

final _dio = Dio(BaseOptions(
  baseUrl: _apiUrl,
  connectTimeout: 5000,
  receiveTimeout: 5000,
));

signUp(name, email, password) async {
  final result = await _dio.post(
    'users/',
    data: {
      'name': name,
      'email': email,
      'password': password,
    },
    options: Options(contentType: Headers.formUrlEncodedContentType),
  );
  return result.data;
}

signIn(email, password) async {
  final result = await _dio.post(
    'users/login/',
    data: {
      'email': email,
      'password': password,
    },
    options: Options(contentType: Headers.formUrlEncodedContentType),
  );
  return result.data;
}

getReports(userId) async {
  final result = await _dio.get(
    'reports/',
    queryParameters: {
      'user_id': userId,
    },
  );
  result.data['reports'].forEach((report) =>
      report['image_url'] = '${_apiUrl}images/${report["image_url"]}');
  return result.data;
}

postReportHair(userId, imageBytes, fileName) async {
  final result = await _dio.post(
    'reports/hair/',
    data: FormData.fromMap({
      'user_id': userId,
      'picture': MultipartFile.fromBytes(
        imageBytes,
        filename: fileName,
      ),
    }),
  );
  return result.data;
}

postReportSkin(userId, imageBytes, fileName) async {
  final result = await _dio.post(
    'reports/skin/',
    data: FormData.fromMap({
      'user_id': userId,
      'picture': MultipartFile.fromBytes(
        imageBytes,
        filename: fileName,
      ),
    }),
  );
  return result.data;
}
