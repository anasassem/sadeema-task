abstract class ApiConsumer {
  Future<dynamic> get(
      String path, {
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      });

  Future<dynamic> post(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      });

  Future<dynamic> put(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      });

  Future<dynamic> delete(
      String path, {
        Object? data,
        Map<String, dynamic>? queryParameters,
        Map<String, String>? headers,
      });
}