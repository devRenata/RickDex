import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick/src/core/endpoints.dart';
import 'package:rick/src/models/dtos/character_dto.dart';
import 'package:rick/src/models/repositories/character_repository.dart';
import 'package:rick/src/models/repositories/character_repository_imp.dart';
import 'package:rick/src/models/repositories/favorites_repository.dart';
import 'package:rick/src/models/repositories/favorites_repository_imp.dart';
import 'package:rick/src/ui/viewmodels/character_viewmodel.dart';
import 'package:rick/src/ui/viewmodels/favorites_viewmodel.dart';

class DependencyInjection {
  static Future<void> initLocalStorage() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CharacterDtoAdapter());
    }

    await Hive.openBox<CharacterDto>('favorites');
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

  static FavoritesRepository createFavoritesRepository() {
    final box = Hive.box<CharacterDto>('favorites');
    return FavoritesRepositoryImp(box: box);
  }

  static FavoritesViewmodel createFavoritesViewmodel() {
    return FavoritesViewmodel(repository: createFavoritesRepository());
  }
}
