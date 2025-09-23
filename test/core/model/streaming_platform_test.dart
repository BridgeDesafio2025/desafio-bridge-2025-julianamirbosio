import 'package:flutter_test/flutter_test.dart';
import 'package:movies__series_app/core/model/streaming_platform.dart'; // Ajuste o caminho se necessário

void main() {
  group('StreamingPlatform.fromJson', () {

    test('Parsear corretamente um JSON', () {
      // Arrange
      final json = <String, dynamic>{
        'name': 'Netflix',
        'type': 'Streaming',
        'logoUrl': 'https://netflix/logo.png',
        'deepLink': 'netflix://title/12345',
      };

      // Act
      final platform = StreamingPlatform.fromJson(json);

      // Assert
      expect(platform.name, 'Netflix');
      expect(platform.type, 'Streaming');
      expect(platform.logoUrl, 'https://netflix/logo.png');
      expect(platform.deepLink, 'netflix://title/12345');
    });

    test('Usar os valores padrão (placeholders) quando os campos do JSON são nulos', () {
      // Arrange
      final json = <String, dynamic>{
        'name': null,
        'type': null,
        'logoUrl': null,
        'deepLink': null,
      };
      const placeholderNetflixUrl = 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3';

      // Act
      final platform = StreamingPlatform.fromJson(json);

      // Assert
      expect(platform.name, 'Plataforma');
      expect(platform.type, 'Streaming');
      expect(platform.logoUrl, placeholderNetflixUrl);
      expect(platform.deepLink, '');
    });

    test('Mesclar dados reais e placeholders corretamente', () {
      // Arrange
      final json = <String, dynamic>{
        'name': 'Amazon Prime',
      };
      const placeholderNetflixUrl = 'https://images.unsplash.com/photo-1611162617474-5b21e879e113?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3';

      // Act
      final platform = StreamingPlatform.fromJson(json);

      // Assert
      expect(platform.name, 'Amazon Prime');
      expect(platform.type, 'Streaming');
      expect(platform.logoUrl, placeholderNetflixUrl);
      expect(platform.deepLink, '');
    });
  });
}