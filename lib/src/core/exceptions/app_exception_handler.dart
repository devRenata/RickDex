import 'package:dio/dio.dart';
import 'package:rick/src/core/exceptions/app_exception.dart';

class AppExceptionHandler {
  static AppException handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();
      case DioExceptionType.badResponse:
        return handleStatusCode(e.response?.statusCode);
      case DioExceptionType.connectionError:
        return NetworkException();
      default:
        return UnknownException(originalException: e.toString());
    }
  }

  static AppException handleStatusCode(int? code) {
    switch (code) {
      case 400:
        return BadRequestException();
      case 404:
        return NotFoundException();
      case 408:
        return TimeoutException();
      case 500:
      case 502:
      case 503:
        return ServerException();
      default:
        return UnknownException();
    }
  }
}