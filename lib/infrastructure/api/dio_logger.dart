import 'package:appointment_booking_challenge/infrastructure/custom_printer.dart';
import 'package:dio/dio.dart';

class DioLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    info('${options.method} - ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debug('${response.statusCode} - ${response.statusMessage}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    error('${err.response?.data}');
    return super.onError(err, handler);
  }
}
