import 'package:dio/dio.dart';
import '../../../features/data/models/model.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<Movie>> fetchData() async {
    try {
      final response = await dio.get(
        'https://imdb-top-100-movies.p.rapidapi.com/',
        options: Options(
          headers: {
            'x-rapidapi-host': 'imdb-top-100-movies.p.rapidapi.com',
            'x-rapidapi-key':
                '0ee011003dmsh11f1e68bb377c92p11d9a0jsne667d2a39ca2',
          },
        ),
      );

      // print('API Response: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((movieData) => Movie.fromJson(movieData)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<List<Movie>> fetchMoviesByGenre(String genre) async {
    try {
      final response = await dio.get(
        'https://imdb-top-100-movies.p.rapidapi.com/',
        queryParameters: {'genre': genre},
        options: Options(
          headers: {
            'x-rapidapi-host': 'imdb-top-100-movies.p.rapidapi.com',
            'x-rapidapi-key':
                '0ee011003dmsh11f1e68bb377c92p11d9a0jsne667d2a39ca2',
          },
        ),
      );
      print("Fetching movies for genre: $genre");
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .where((movie) =>
                (movie['genre'] as String?)?.contains(genre) ?? false)
            .map((movieData) => Movie.fromJson(movieData))
            .toList();
      } else {
        throw Exception('Failed to load movies by genre');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch data by genre: $e');
    }
  }
}
