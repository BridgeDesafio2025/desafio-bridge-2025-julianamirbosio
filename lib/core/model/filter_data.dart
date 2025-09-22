import '../enums/media_type.dart';

class FilterData {
  final MediaType? type;
  final List<String>? genre;
  final int? year;
  final double? rating;

  const FilterData({
    this.type,
    this.genre,
    this.year,
    this.rating,
  });

  bool get isEmpty =>
      type == null &&
      (genre == null || genre!.isEmpty) &&
      year == null &&
      rating == null;

  FilterData copyWith({
    MediaType? type,
    List<String>? genre,
    int? year,
    double? rating,
  }) {
    return FilterData(
      type: type ?? this.type,
      genre: genre ?? this.genre,
      year: year ?? this.year,
      rating: rating ?? this.rating,
    );
  }

  Map<String, String> toQueryParams() {
    final params = <String, String>{};

    if (type != null) {
      params['type'] = type!.name;
    }
    if (genre != null && genre!.isNotEmpty) {
      params['genre'] = genre!.join(',');
    }
    if (year != null) {
      params['year'] = year.toString();
    }
    if (rating != null) {
      params['rating'] = rating.toString();
    }

    return params;
  }

  String toReadableString() {
    if (isEmpty) {
      return 'Nenhum filtro aplicado.';
    }

    List<String> parts = [];

    // Indica o tipo do conteúdo
    if (type != null) {
      parts.add('para ${type!.ptBrName}');
    }

    // Adiciona os gêneros (ex: "do gênero Ação e Drama")
    if (genre != null && genre!.isNotEmpty) {
      if (genre!.length == 1) {
        parts.add('do gênero ${genre![0]}');
      } else {
        String lastGenre = genre!.removeLast();
        parts.add('dos gêneros ${genre!.join(', ')} e ${lastGenre}');
      }
    }

    // Adiciona o ano (ex: "de 1993")
    if (year != null) {
      parts.add('de $year');
    }

    // Adiciona a avaliação (ex: "com mais de 5.0 estrelas")
    if (rating != null) {
      parts.add('com pelo menos ${rating} estrelas');
    }

    // Junta as strings
    return 'Não encontramos conteúdo ${parts.join(' ')}.';
  }

  @override
  String toString() {
    var string = '';
    if (type != null) string += 'type: ${type!.ptBrName}, ';
    if (genre != null) string += 'genre: $genre, ';
    if (year != null) string += 'year: $year, ';
    if (rating != null) string += 'rating >= $rating, ';
    if (string.endsWith(', ')) {
      string = string.substring(0, string.length - 2);
    }

    return string;
  }
}
