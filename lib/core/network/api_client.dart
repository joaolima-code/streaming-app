import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
          'Accept': 'application/json',
        },
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest:
              (
                RequestOptions options,
                RequestInterceptorHandler handler,
              ) async {
                final String? token = dotenv.env['API_TOKEN'];
                options.headers['Authorization'] = 'Bearer $token';

                return handler.next(options);
              },
          onError: (DioException error, ErrorInterceptorHandler handler) {
            debugPrint('Dio Error: ${error.message}');
            return handler.next(error);
          },
        ),
      );
    }
  }

  static const String baseUrl = 'https://api.themoviedb.org/3';

  late final Dio dio;
}
