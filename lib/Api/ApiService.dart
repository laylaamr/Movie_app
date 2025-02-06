import 'package:dio/dio.dart';
import 'model.dart';

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
            'x-rapidapi-key': '0ee011003dmsh11f1e68bb377c92p11d9a0jsne667d2a39ca2',
          },
        ),
      );

      // Log the response
      print('API Response: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((movieData) => Movie.fromJson(movieData)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      // Handle errors and exceptions
      print('Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }
}
