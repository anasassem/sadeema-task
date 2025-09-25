import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../storage/secure_storage.dart';


class ApiInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Add authorization token if available


    // Add language header
    options.headers['Accept-Language'] = 'ar';

    // Add platform header
    options.headers['Platform'] = _getPlatform();

    if (kDebugMode) {
      print('🚀 Request: ${options.method} ${options.uri}');
      if (options.data != null) {
        print('📤 Request Data: ${options.data}');
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    if (kDebugMode) {
      print('✅ Response: ${response.statusCode} ${response.requestOptions.uri}');
      print('📥 Response Data: ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    if (kDebugMode) {
      print('❌ Error: ${err.type} ${err.requestOptions.uri}');
      print('💥 Error Message: ${err.message}');
      if (err.response != null) {
        print('📥 Error Response: ${err.response?.data}');
      }
    }

    // Handle 401 unauthorized - redirect to login
    if (err.response?.statusCode == 401) {
      _handleUnauthorized();
    }

    super.onError(err, handler);
  }

  String _getPlatform() {
    if (kIsWeb) return 'web';
    return defaultTargetPlatform.name.toLowerCase();
  }

  void _handleUnauthorized() {
    // Clear stored token


    // Navigate to login screen
    // This would typically be handled by your navigation service
    // navigatorKey.currentState?.pushReplacementNamed('/login');
  }
}