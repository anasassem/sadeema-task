import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../erros/exceptions.dart';
import 'api_consumer.dart';
import 'api_interceptors.dart';
import 'end_point.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer(this.dio) {
    dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors
    dio.interceptors.add(ApiInterceptors());

    // Add logging interceptor in debug mode
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: false,
          error: true,
        ),
      );
    }
  }

  @override
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw ServerException('Unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<dynamic> post(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw ServerException('Unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<dynamic> put(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw ServerException('Unexpected error occurred: ${e.toString()}');
    }
  }

  @override
  Future<dynamic> delete(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw ServerException('Unexpected error occurred: ${e.toString()}');
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw ServerException(
        'Server returned status code: ${response.statusCode} with message: ${response.statusMessage}',
      );
    }
  }

  Never _handleDioError(DioException error) {
    String message;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send timeout. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        message = _handleStatusCode(error.response?.statusCode);
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled.';
        break;
      case DioExceptionType.connectionError:
        message = 'No internet connection. Please check your network.';
        break;
      case DioExceptionType.badCertificate:
        message = 'Certificate error. Please try again.';
        break;
      case DioExceptionType.unknown:
        message = 'Unknown error occurred. Please try again.';
        break;
    }

    throw ServerException(message);
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Forbidden. You don\'t have permission to access this resource.';
      case 404:
        return 'Resource not found.';
      case 422:
        return 'Validation error. Please check your input.';
      case 500:
        return 'Internal server error. Please try again later.';
      case 502:
        return 'Bad gateway. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      default:
        return 'Server error occurred. Please try again.';
    }
  }
}