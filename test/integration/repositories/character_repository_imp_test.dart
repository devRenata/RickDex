import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick/src/models/entities/character.dart';
import 'package:rick/src/models/repositories/character_repository.dart';
import 'package:rick/src/models/repositories/character_repository_imp.dart';

void main() {
  late CharacterRepository repository;

  setUp(() {
    repository = CharacterRepositoryImp(dio: Dio());
  });

  test('Deve retornar uma lista de Characters com sucesso', () async {
    final result = await repository.getCharacters(page: 1);

    expect(result, isA<List<Character>>());
    expect(result.length, equals(20));
  });
}
