import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _dioClient = DioClient._internal();
  Dio _dio = new Dio();

  Dio get dio => _dio;

  factory DioClient() {
    return _dioClient;
  }

  DioClient._internal() {
    _dio.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));
  }
}
