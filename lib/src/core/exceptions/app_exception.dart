/// Base App Exception
abstract class AppException implements Exception {
  final String message;
  final String code;
  final int status;
  final String? originalException;

  AppException({
    required this.message,
    required this.code,
    required this.status,
    required this.originalException,
  });

  @override
  String toString() => 'AppException: [$status] $code: $message';
}

class NetworkException extends AppException {
  NetworkException([String? originalException])
      : super(
          message: 'Erro de conexão. Verifique sua internet.',
          code: 'NETWORK_ERROR',
          status: 0,
          originalException: originalException,
        );
}

class ServerException extends AppException {
  ServerException([String? originalException])
      : super(
          message: 'Erro no servidor. Tente novamente mais tarde.',
          code: 'SERVER_ERROR',
          status: 500,
          originalException: originalException,
        );
}

class TimeoutException extends AppException {
 TimeoutException([String? originalException])
      : super(
          message: 'Tempo de conexão excedido. Verifique sua internet.',
          code: 'TIMEOUT_ERROR',
          status: 408,
          originalException: originalException,
        );
}

class BadRequestException extends AppException {
 BadRequestException([String? originalException])
      : super(
          message: 'Requisição inválida. Tente novamente mais tarde.',
          code: 'BAD_REQUEST_ERROR',
          status: 400,
          originalException: originalException,
        );
}

class NotFoundException extends AppException {
 NotFoundException([String? originalException])
      : super(
          message: 'Recurso não encontrado. Tente novamente mais tarde.',
          code: 'NOTFOUND_ERROR',
          status: 404,
          originalException: originalException,
        );
}

class DataParsingException extends AppException {
 DataParsingException({super.originalException})
      : super(
          message: 'Erro ao processar dados. Tente novamente mais tarde.',
          code: 'DATA_PARSING_ERROR',
          status: 0,
        );
}

class UnknownException extends AppException {
  UnknownException({super.originalException})
      : super(
          message: 'Erro desconhecido. Tente novamente.',
          code: 'UNKNOWN_ERROR',
          status: 0,
        );
}
