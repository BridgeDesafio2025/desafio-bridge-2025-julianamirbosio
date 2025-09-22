import 'package:flutter_test/flutter_test.dart';
import 'package:movies__series_app/core/enums/media_type.dart';
import 'package:movies__series_app/core/model/medium.dart';

void main() {
  group('Medium.fromJson', () {
    test('Parsear corretamente um JSON de filme completo', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': 1, 'title': 'Teste - O filme', 'type': 'movie', 'genre': ['Ação'],
        'rating': 4.8, 'streamingPlatforms': [], 'poster': 'https://url.do.poster/poster.jpg',
        'synopsis': 'Uma sinopse de teste.', 'year': 2025, 'duration': '90 min',
        'ratings': []
      };

      // Act
      final medium = Medium.fromJson(json);

      // Assert
      expect(medium.id, 1);
      expect(medium.title, 'Teste - O filme');
      expect(medium.type, MediaType.movie);
      expect(medium.poster, 'https://url.do.poster/poster.jpg');
      expect(medium.year, 2025);
    });

    test('Lidar com campos opcionais ausentes (ex: poster)', () {
      // Arrange
      // Este JSON não tem a chave 'poster'.
      final Map<String, dynamic> json = {
        'id': 2, 'title': 'Filme Sem Poster', 'type': 'movie', 'genre': [],
        'rating': 4.0, 'streamingPlatforms': [], 'synopsis': '',
        'year': 2024, 'duration': '100 min', 'ratings': []
      };

      // Act
      final medium = Medium.fromJson(json);

      // Assert
      expect(medium.poster, isNull);
    });

    test('Parsear corretamente um JSON de série com temporadas e episódios', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': 3, 'title': 'Teste - o seriado', 'type': 'series', 'genre': ['Drama'],
        'rating': 4.9, 'streamingPlatforms': [], 'poster': 'https://url.do.poster/serie.jpg',
        'synopsis': 'Uma sinopse de série.', 'year': 2023, 'duration': '50 min/ep',
        'seasons': 5, 'episodes': 50, 'ratings': []
      };

      // Act
      final medium = Medium.fromJson(json);

      // Assert
      expect(medium.type, MediaType.series);
      expect(medium.seasons, 5);
      expect(medium.episodes, 50);
    });

    test('deve ter campos de série nulos quando o tipo for filme', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': 4, 'title': 'Apenas um Filme', 'type': 'movie', 'genre': [],
        'rating': 3.5, 'streamingPlatforms': [], 'synopsis': '',
        'year': 2022, 'duration': '90 min', 'ratings': []
      };

      // Act
      final medium = Medium.fromJson(json);

      // Assert
      expect(medium.type, MediaType.movie);
      expect(medium.seasons, isNull);
      expect(medium.episodes, isNull);
    });
  });
}