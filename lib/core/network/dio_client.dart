import 'package:crypto_rtq/core/constants/api_endpoints.dart';
import 'package:dio/dio.dart';
import 'interceptors/log_interceptor.dart';

class DioClient {
  final Dio dio;

  DioClient()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 10),
          responseType: ResponseType.json,
          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    dio.interceptors.addAll([CustomLogInterceptor()]);
  }
}
