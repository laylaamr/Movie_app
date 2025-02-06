
import '../Api/ApiService.dart';
import '../Api/model.dart';


class MovieRepository {
  final ApiService apiService;

  MovieRepository({required this.apiService});


  Future<List<Movie>> getMovies() async {
    try {
      final List<Movie> movies = await apiService.fetchData(); // استخدام ApiService
      return movies;
    } catch (e) {
      throw Exception('Error fetching movies: $e');
    }
  }
}
