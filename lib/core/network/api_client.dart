import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  ApiClient() {
    dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: kDebugMode,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          headers: <String, dynamic>{
            'Content-Type': 'application/json',
            'Accept': 'application/json'
          }),
    );

    dio.interceptors.add(InterceptorsWrapper(onRequest: (
      RequestOptions options,
      RequestInterceptorHandler handler,
    ) async {
      options.headers['Authorization'] = 'Bearer $apiKey';

      return handler.next(options);
    }, onError: (DioException error, ErrorInterceptorHandler handler) {
      debugPrint('Dio Error: ${error.message}');
      return handler.next(error);
    }));
  }

  static const String baseUrl = 'https://api.themoviedb.org/3';

  static const String apiKey = String.fromEnvironment('API_KEY');

  late final Dio dio;
}
