import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:appointment_booking_challenge/infrastructure/api/dio_logger.dart';
import 'package:appointment_booking_challenge/infrastructure/api/endpoints.dart';

@lazySingleton
class ApiService {
  static ApiService? _instance;
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Endpoint.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 50),
    ),
  )..interceptors.add(DioLogger());

  ApiService._();

  factory ApiService() {
    _instance ??= ApiService._();
    return _instance!;
  }

  Future<T> get<T>(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(path, queryParameters: params);
      return response.data as T;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<T> post<T>(String path, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.post(path, data: body);
      return response.data as T;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.response == null) {
      return Exception('Network error occurred');
    }
    return Exception(e.response!.statusCode);
  }
}
