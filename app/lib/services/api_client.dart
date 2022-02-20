import 'package:dio/dio.dart';

final _dio = Dio(BaseOptions(
  baseUrl: 'http://192.168.18.8/',
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
  return result.data;
}
