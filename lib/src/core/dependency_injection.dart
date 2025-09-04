import 'package:dio/dio.dart';
import 'package:rick/src/core/endpoints.dart';
import 'package:rick/src/models/repositories/character_repository.dart';
import 'package:rick/src/models/repositories/character_repository_imp.dart';
import 'package:rick/src/ui/viewmodels/character_viewmodel.dart';

class DependencyInjection {
  static Dio createDio() {
    return Dio(BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
  }

  static CharacterRepository createCharacterRepository() {
    return CharacterRepositoryImp(dio: createDio());
  }

  static CharacterViewmodel createCharacterViewmodel() {
    return CharacterViewmodel(repository: createCharacterRepository());
  }
}
