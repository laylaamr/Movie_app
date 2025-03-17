import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/model.dart';
import 'cubitRepo.dart';
import 'movieState.dart';

class CubitMovie extends Cubit<MovieState> {
  final MovieRepository movieRepository;

  CubitMovie({required this.movieRepository}) : super(MovieLoading());

  Future<void> fetchMovies() async {
    try {
      final List<Movie> movies = await movieRepository.getMovies();
      emit(MovieLoaded(movies));
    } catch (error) {
      emit(MovieError(error.toString()));
    }
  }

  Future<void> fetchMoviesByGenre(String genre) async {
    emit(MovieLoading());
    try {
      final List<Movie> movies = await movieRepository.getMoviesByGenre(genre);
      emit(MovieLoaded(movies));
    } catch (error) {
      emit(MovieError(error.toString()));
    }
  }
}

// class CubitMovie extends Cubit<MovieState> {
//   final ApiService apiService;
//
//   CubitMovie() : apiService = ApiService(Dio()), super(MovieLoading());
//
//   Future<void> fetchMovie() async {
//     try {
//       final List<Movie> movies = await apiService.fetchData();
//       emit(MovieLoaded(movies));
// // Emit loaded state with movies
//     } catch (error) {
//       emit(MovieError(error.toString())); // Emit error state if any
//     }
//   }
// }
