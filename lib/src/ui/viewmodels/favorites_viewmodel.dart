import 'package:flutter/material.dart';
import 'package:rick/src/core/exceptions/app_exception.dart';
import 'package:rick/src/models/entities/character.dart';
import 'package:rick/src/models/repositories/favorites_repository.dart';

class FavoritesViewmodel extends ChangeNotifier {
  final FavoritesRepository repository;
  FavoritesViewmodel({required this.repository});

  List<Character> _favorites = [];
  List<Character> get favorites => _favorites;

  bool isLoading = false;
  AppException? error;

  Future<void> getFavorites({bool loadMore = false}) async {
    if (isLoading) return;

    try {
      isLoading = true;
      _favorites = [];
      error = null;

      notifyListeners();

      final favoritesResult = await repository.getFavorites();
      _favorites.addAll(favoritesResult);
      error = null;

    } on AppException catch (e) {
      error = e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFavorite({required Character character}) async {
    await repository.addFavorite(character: character);
    _favorites.add(character);
    notifyListeners();
  }

  Future<void> removeFavorite({required Character character}) async {
    await repository.removeFavorite(character: character);
    _favorites.removeWhere((c) => c.id == character.id);
    notifyListeners();
  }

  bool isFavorite(Character character) {
    return _favorites.any((c) => c.id == character.id);
  }

  void clearError() {
    error = null;
    notifyListeners();
  } 
}