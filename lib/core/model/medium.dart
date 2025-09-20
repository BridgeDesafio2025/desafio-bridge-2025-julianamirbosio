import 'package:movies__series_app/core/model/rating.dart';
import 'package:movies__series_app/core/model/streaming_platform.dart';

import '../enums/media_type.dart';

class Medium {
  final int id;
  final String title;
  final MediaType type;
  final List<String> genres;
  final double rating;
  final List<StreamingPlatform> streamingPlatforms;
  final String? poster;
  final String synopsis;
  final int year;
  final String duration;
  final int? seasons;
  final int? episodes;
  final List<Rating> ratings;

  Medium({
    required this.id,
    required this.title,
    required this.type,
    required this.genres,
    required this.rating,
    required this.streamingPlatforms,
    this.poster,
    required this.synopsis,
    required this.year,
    required this.duration,
    this.seasons,
    this.episodes,
    required this.ratings,
  });

  factory Medium.fromJson(Map<String, dynamic> json) {
    return Medium(
      id: json['id'],
      title: json['title'],
      type: MediaType.values.firstWhere(
        (type) =>
            type.name.toLowerCase() == json['type'].toString().toLowerCase(),
        orElse: () => MediaType.movie,
      ),
      genres: List<String>.from(json['genre']),
      rating: (json['rating'] as num).toDouble(),
      streamingPlatforms: (json['streamingPlatforms'] as List<dynamic>?)
              ?.map((e) => StreamingPlatform.fromJson(e))
              .toList() ??
          [],
      poster: json['poster'],
      synopsis: json['synopsis'],
      year: json['year'],
      duration: json['duration'],
      seasons: json['seasons'],
      episodes: json['episodes'],
      ratings: (json['ratings'] as List<dynamic>?)
              ?.map((e) => Rating.fromJson(e))
              .toList() ??
          [],
    );
  }
}
