import 'package:flutter_test/flutter_test.dart';
import 'package:movies__series_app/core/enums/media_type.dart';
import 'package:movies__series_app/core/model/filter_data.dart';

void main() {
  group('FilterData', () {
    test('Formatar corretamente um filtro completo', () {
      // Arrange
      final filter = FilterData(
        type: MediaType.movie,
        genre: ['Ação', 'Aventura'],
        rating: 4.5,
      );

      // Act
      final params = filter.toQueryParams();

      // Assert
      expect(params['type'], 'movie');
      expect(params['genre'], 'Ação,Aventura');
      expect(params['rating'], '4.5');
    });

    test('Ignorar uma lista de gênero vazia', () {
      // Arrange
      const filter = FilterData(genre: []);
      // Act
      final params = filter.toQueryParams();
      // Assert
      expect(params.containsKey('genre'), isFalse);
    });

    test('Formatar corretamente para um único gênero', () {
      // Arrange
      const filter = FilterData(genre: ['Aventura']);
      // Act
      final message = filter.toReadableString();
      // Assert
      expect(message, 'Não encontramos conteúdo do gênero Aventura.');
    });

    test('Formatar corretamente para mais de um gênero', () {
      // Arrange
      final filter = FilterData(genre: ['Drama', 'Suspense']);
      // Act
      final message = filter.toReadableString();
      // Assert
      expect(message, 'Não encontramos conteúdo dos gêneros Drama e Suspense.');
    });
  });
}
