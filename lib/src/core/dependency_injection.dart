import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick/src/core/endpoints.dart';
import 'package:rick/src/models/entities/character.dart';
import 'package:rick/src/models/repositories/character_repository.dart';
import 'package:rick/src/models/repositories/character_repository_imp.dart';
import 'package:rick/src/ui/viewmodels/character_viewmodel.dart';

class DependencyInjection {
  static Future<void> initLocalStorage() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CharacterAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CharacterStatusAdapter());
    }

    await Hive.openBox<Character>('favorites');
  }

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
