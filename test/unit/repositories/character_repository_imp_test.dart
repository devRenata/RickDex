import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick/src/core/endpoints.dart';
import 'package:rick/src/core/exceptions/app_exception.dart';
import 'package:rick/src/models/entities/character.dart';
import 'package:rick/src/models/repositories/character_repository.dart';
import 'package:rick/src/models/repositories/character_repository_imp.dart';

class DioMock extends Mock implements Dio {}

void main() {
  late CharacterRepository repository;
  late DioMock dio;

  setUp(() {
    dio = DioMock();
    repository = CharacterRepositoryImp(dio: dio);
  });

  test('Deve retornar uma lista de Characters com sucesso', () async {
    final responsePayload = {
      "results": [
        {
          "id": 361,
          "name": "Toxic Rick",
          "status": "Dead",
          "species": "Humanoid",
          "type": "Rick's Toxic Side",
          "gender": "Male",
          "origin": {"name": "Alien Spa", "url": ""},
          "location": {"name": "Earth", "url": ""},
          "image": "https://rickandmortyapi.com/api/character/avatar/361.jpeg",
          "episode": ["https://rickandmortyapi.com/api/episode/27"],
          "url": "https://rickandmortyapi.com/api/character/361",
          "created": "2018-01-10T18:20:41.703Z"
        },
      ],
    };

    when(() => dio.get('${Endpoints.characters}?page=1'))
        .thenAnswer((_) async => Response(
              requestOptions: RequestOptions(),
              statusCode: 200,
              data: responsePayload,
            ));

    final result = await repository.getCharacters(page: 1);
    expect(result, isA<List<Character>>());
    expect(result.length, 1);
    expect(result.first.name, 'Toxic Rick');
  });

  group("Exceptions | ", () { 
    test('Deve lançar ServerException quando ocorrer erro no servidor', () async {
      when(() => dio.get('${Endpoints.characters}?page=1')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '${Endpoints.characters}?page=1'),
          response: Response(
            requestOptions: RequestOptions(path: '${Endpoints.characters}?page=1'),
            statusCode: 500,
            data: {},
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(
        () => repository.getCharacters(page: 1),
        throwsA(isA<ServerException>()),
      );
    });

    test('Deve lançar NetworkException quando ocorrer erro de conexão', () async {
      when(() => dio.get('${Endpoints.characters}?page=1')).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(
        () => repository.getCharacters(page: 1),
        throwsA(isA<NetworkException>()),
      );
    });

    test('Deve lançar DataParsingException quando o JSON for inválido', () async {
      when(() => dio.get('${Endpoints.characters}?page=1')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: {
            'results': [{'id': 'no-number'}],
          },
        ),
      );

      expect(
        () => repository.getCharacters(page: 1),
        throwsA(isA<DataParsingException>()),
      );
    });

    test('Deve lançar TimeoutException quando ocorrer timeout de conexão', () async {
      when(() => dio.get('${Endpoints.characters}?page=1')).thenThrow(
        DioException(
          requestOptions: RequestOptions(),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(
        () => repository.getCharacters(page: 1),
        throwsA(isA<TimeoutException>()),
      );
    });
  });
}
