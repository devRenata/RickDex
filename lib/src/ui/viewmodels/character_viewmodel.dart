import 'package:flutter/material.dart';
import 'package:rick/src/core/exceptions/app_exception.dart';
import 'package:rick/src/models/entities/character.dart';
import 'package:rick/src/models/repositories/character_repository.dart';

class CharacterViewmodel extends ChangeNotifier {
  final CharacterRepository repository;
  CharacterViewmodel({required this.repository});

  List<Character> _characters = [];
  List<Character> get characters => _characters;

  bool isLoading = false;
  bool isLoadidngMore = false;
  bool hasMore = true;
  int currentPage = 1;
  AppException? error;

  Future<void> getCharacters({bool loadMore = false}) async {
    if (isLoading || isLoadidngMore) return;

    try {
      if (loadMore) {
        isLoadidngMore = true;
      } else {
        isLoading = true;
        currentPage = 1;
        hasMore = true;
        _characters = [];
      }
      
      error = null;
      notifyListeners();

      final newCharacters = await repository.getCharacters(page: currentPage);

      if (newCharacters.isEmpty) {
        hasMore = false;
      } else {
        _characters.addAll(newCharacters);
        currentPage++;
      }

      error = null;
    } on AppException catch (e) {
      error = e;
      if (!loadMore) {
        _characters = [];
      }
    } finally {
      isLoading = false;
      isLoadidngMore = false;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    await getCharacters(loadMore: false);
  }

  Future<void> loadMore() async {
    if (hasMore && !isLoading && !isLoadidngMore) {
      await getCharacters(loadMore: true);
    }
  }

  void clearError() {
    error = null;
    notifyListeners();
  } 
}