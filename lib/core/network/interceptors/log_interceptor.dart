import 'package:crypto_rtq/core/utils/app_logger.dart';
import 'package:dio/dio.dart';

class CustomLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.info(
      '[REQUEST] => ${options.method.toUpperCase()} ${options.uri}',
    );
    AppLogger.info('[HEADERS] => ${options.headers}');
    if (options.data != null) {
      AppLogger.info('[BODY] => ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final status = response.statusCode ?? 0;
    if (status >= 200 && status < 300) {
      AppLogger.success(
        '[RESPONSE] => ${response.statusCode} ${response.requestOptions.uri}',
      );
    } else {
      AppLogger.warning(
        '[RESPONSE] => ${response.statusCode} ${response.requestOptions.uri}',
      );
    }
    AppLogger.info('[DATA] => ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final status = err.response?.statusCode;
    AppLogger.error('[ERROR] => [$status] ${err.message}');
    AppLogger.error('[URI] => ${err.requestOptions.uri}');
    if (err.response?.data != null) {
      AppLogger.error('[RESPONSE BODY] => ${err.response?.data}');
    }
    handler.next(err);
  }
}
