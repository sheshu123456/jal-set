import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(connectTimeout: const Duration(seconds: 15), receiveTimeout: const Duration(seconds: 20)));

  Future<Response<T>> get<T>(String url, {Map<String, dynamic>? query}) async {
    return _dio.get<T>(url, queryParameters: query);
  }

  Future<Response<T>> post<T>(String url, dynamic data) async {
    return _dio.post<T>(url, data: data);
  }
}

