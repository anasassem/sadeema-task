import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          "Connection timeout. Please check your internet connection.",
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          "Request timeout while sending data to the server.",
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          "Response timeout. The server took too long to respond.",
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          "Invalid certificate. The server's SSL certificate is not trusted.",
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure("Request was cancelled before completion.");
      case DioExceptionType.connectionError:
        return ServerFailure("Connection error. Unable to reach the server.");
      case DioExceptionType.unknown:
        return ServerFailure("An unexpected error occurred. Please try again.");
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure(
        "Bad request Your Request is not found, please try again",
      );
    } else if (statusCode == 500) {
      return ServerFailure("Internal server error. Please try again later.");
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response["error"]["message"]);
    } else {
      return ServerFailure("An unexpected error occurred. Please try again.");
    }
  }
}

class CacheFailure extends Failure {
  CacheFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}
