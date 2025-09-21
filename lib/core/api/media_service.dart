import 'package:dio/dio.dart';

import 'endpoints.dart';
import '../model/actor.dart';
import '../model/filter_data.dart';
import '../model/medium.dart';
import '../model/page.dart';

class MediaService {
  final Dio _dio;

  MediaService({required Dio dio}) : _dio = dio;
  Future<Page<Medium>> getMediaPage({
    int page = 1,
    FilterData? filterData,
  }) async {
    final response = await _dio.get(
      Endpoints.media(),
      queryParameters: {
        'page': page,
        if (filterData != null) ...filterData.toQueryParams(),
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = (response.data as Map<String, dynamic>);
      return Page<Medium>.fromJson(
        jsonResponse,
        (json) => Medium.fromJson(json),
      );
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<Actor>> getMediumCast(int id) async {
    final response = await _dio.get(Endpoints.cast(id: id));

    if (response.statusCode == 200) {
      List jsonResponse = response.data;

      return jsonResponse.map((actor) => Actor.fromJson(actor)).toList();
    } else {
      throw Exception('Failed to load movie cast');
    }
  }

  Future<Map<String, dynamic>> getMediumRatings(int id) async {
    final response = await _dio.get(Endpoints.ratings(id: id));

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load movie ratings');
    }
  }
}
