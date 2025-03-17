import '../../../core/networking/Api/ApiService.dart';
import '../../data/models/model.dart';

class MovieRepository {
  final ApiService apiService;

  MovieRepository({required this.apiService});

  Future<List<Movie>> getMovies() async {
    try {
      final List<Movie> movies = await apiService.fetchData();
      return movies;
    } catch (e) {
      throw Exception('Error fetching movies: $e');
    }
  }

  Future<List<Movie>> getMoviesByGenre(String genre) async {
    try {
      final List<Movie> allMovies = await apiService.fetchData();
      return allMovies.where((movie) => movie.genre.contains(genre)).toList();
    } catch (e) {
      throw Exception('Error fetching movies by genre: $e');
    }
  }
}
