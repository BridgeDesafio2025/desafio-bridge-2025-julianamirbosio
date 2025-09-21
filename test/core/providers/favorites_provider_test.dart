import 'package:flutter_test/flutter_test.dart';

import 'package:movies__series_app/core/providers/favorites_provider.dart';
import 'package:movies__series_app/core/model/medium.dart';
import 'package:movies__series_app/core/enums/media_type.dart';

void main() {
  group('FavoritesProvider', () {
    test('Adicionar um item à lista de favoritos', () {
      // Arrange
      final favoritesProvider = FavoritesProvider();
      final testMedium = Medium(
        id: 1, 
        title: 'Teste - O Filme', 
        type: MediaType.movie, 
        genres: [], 
        rating: 5.0, 
        streamingPlatforms: [], 
        synopsis: 'synopsis', 
        year: 2025, 
        duration: '90 min', 
        ratings: []
      );

      // Act 
      favoritesProvider.addFavorite(testMedium);

      // Assert
      // Esperamos que contenha o testMedium
      expect(favoritesProvider.favorites.contains(testMedium), isTrue);
      // Esperamos que a lista nao esteja vazia
      expect(favoritesProvider.favorites.isNotEmpty, isTrue);
    });

    test('Remover um item da lista de favoritos', () {
      // Arrange
      final favoritesProvider = FavoritesProvider();
      final testMedium = Medium(
        id: 1, 
        title: 'Teste - O Filme', 
        type: MediaType.movie, 
        genres: [], 
        rating: 5.0, 
        streamingPlatforms: [], 
        synopsis: 'synopsis', 
        year: 2025, 
        duration: '90 min', 
        ratings: []
      );

      // Act 
      favoritesProvider.removeFavorite(testMedium);

      // Assert
      // Esperamos que a lista esteja vazia
      expect(favoritesProvider.favorites.isEmpty, isTrue);
    });

    test('Retornar true para um item favoritado', () {
      // Arrange
      final favoritesProvider = FavoritesProvider();
      final testMedium = Medium(
        id: 1, 
        title: 'Teste - O Filme', 
        type: MediaType.movie, 
        genres: [], 
        rating: 5.0, 
        streamingPlatforms: [], 
        synopsis: 'synopsis', 
        year: 2025, 
        duration: '90 min', 
        ratings: []
      );
      favoritesProvider.addFavorite(testMedium);

      // Act 
      final result = favoritesProvider.isFavorite(testMedium);

      // Assert
      expect(result, isTrue);
    });

    test('Retornar false para um item não favoritado', () {
      // Arrange
      final favoritesProvider = FavoritesProvider();
      final testMedium = Medium(
        id: 1, 
        title: 'Teste - O Filme', 
        type: MediaType.movie, 
        genres: [], 
        rating: 5.0, 
        streamingPlatforms: [], 
        synopsis: 'synopsis', 
        year: 2025, 
        duration: '90 min', 
        ratings: []
      );
      favoritesProvider.addFavorite(testMedium);
      favoritesProvider.removeFavorite(testMedium);

      // Act 
      final result = favoritesProvider.isFavorite(testMedium);

      // Assert
      expect(result, isFalse);
    });
    
    test('Adicionar um item se ele não estiver na lista de favoritos', () {
      // Arrange
      final favoritesProvider = FavoritesProvider();
      final testMedium = Medium(
        id: 1, 
        title: 'Teste - O Filme', 
        type: MediaType.movie, 
        genres: [], 
        rating: 5.0, 
        streamingPlatforms: [], 
        synopsis: 'synopsis', 
        year: 2025, 
        duration: '90 min', 
        ratings: []
      );

      // Act 
      favoritesProvider.toggleFavorite(testMedium);

      // Assert
      // Esperamos que a lista contenha um item
      expect(favoritesProvider.favorites.length, 1);
      // Esperamos que o item seja o testMedium
      expect(favoritesProvider.favorites.first.id, 1);
    });
  });
}