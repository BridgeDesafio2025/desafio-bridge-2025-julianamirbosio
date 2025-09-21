import 'package:flutter/material.dart';
import '../model/medium.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Medium> _favorites = [];

  List<Medium> get favorites => _favorites;

  bool isFavorite(Medium content) => _favorites.contains(content);

  void addFavorite(Medium content) {
    if (!_favorites.contains(content)) {
      _favorites.add(content);
      notifyListeners();
    }
  }

  void removeFavorite(Medium content) {
    _favorites.remove(content);
    notifyListeners();
  }

  void toggleFavorite(Medium content) {
    if (isFavorite(content)) {
      removeFavorite(content);
    } else {
      addFavorite(content);
    }
  }
}