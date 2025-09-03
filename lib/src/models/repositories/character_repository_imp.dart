import 'package:dio/dio.dart';
import 'package:rick/src/core/exceptions/app_exception.dart';
import 'package:rick/src/core/endpoints.dart';
import 'package:rick/src/core/exceptions/app_exception_handler.dart';
import 'package:rick/src/data/entities/character.dart';
import 'package:rick/src/data/repositories/character_repository.dart';

class CharacterRepositoryImp implements CharacterRepository {
  final Dio dio;
  CharacterRepositoryImp({required this.dio});

  @override
  Future<List<Character>> getCharacters({required int page}) async {
    try {
      final response = await dio.get(
        '${Endpoints.characters}?page=$page',
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw AppExceptionHandler.handleDioException(e);
    } catch (e) {
      throw UnknownException(originalException: e.toString());
    }
  }
}

List<Character> _handleResponse(Response response) {
  if (response.statusCode == 200) {
    try {
      final data = response.data['results'] as List;
      return data.map((json) => Character.fromJson(json)).toList();
    } on FormatException catch (e) {
      throw DataParsingException(originalException: e.toString());
    } on TypeError catch (e) {
      throw DataParsingException(originalException: e.toString());
    }
  } else {
    throw AppExceptionHandler.handleStatusCode(response.statusCode);
  }
}
