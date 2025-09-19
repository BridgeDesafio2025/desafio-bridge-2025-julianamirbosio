import 'package:movies__series_app/core/model/rating.dart';

import '../enums/media_type.dart';

class Medium {
  final int id;
  final MediaType type;
  final String title;
  final List<String> genres;
  final String synopsis;
  final double rating;
  final String? poster;
  final int year;
  final String duration;
  final int? episodes;
  final int? seasons;
  final List<Rating> ratings;

  Medium({
    required this.id,
    required this.type,
    required this.title,
    required this.genres,
    required this.synopsis,
    required this.rating,
    this.poster,
    required this.year,
    required this.duration,
    this.episodes,
    this.seasons,
    required this.ratings,
  });

  factory Medium.fromJson(Map<String, dynamic> json) {
    return Medium(
      id: json['id'],
      type: MediaType.values.firstWhere(
        (type) =>
            type.name.toLowerCase() == json['type'].toString().toLowerCase(),
        orElse: () => MediaType.movie,
      ),
      title: json['title'],
      genres: List<String>.from(json['genre']),
      synopsis: json['synopsis'],
      rating: (json['rating'] as num).toDouble(),
      poster: json['poster'],
      year: json['year'],
      duration: json['duration'],
      episodes: json['episodes'],
      seasons: json['seasons'],
      ratings: (json['ratings'] as List<dynamic>?)
              ?.map((e) => Rating.fromJson(e))
              .toList() ??
          [],
    );
  }
}
