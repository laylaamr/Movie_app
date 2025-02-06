import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled122222/Api/ApiService.dart';
import 'package:untitled122222/cubitFiles/movieState.dart';

import '../Api/model.dart';


import 'cubitRepo.dart';


class CubitMovie extends Cubit<MovieState> {
  final MovieRepository movieRepository;

  CubitMovie({required this.movieRepository}) : super(MovieLoading());

  Future<void> fetchMovies() async {
    try {
      final List<Movie> movies = await movieRepository.getMovies(); // جلب الأفلام من الـ repository
      emit(MovieLoaded(movies)); // إصدار حالة loaded مع الأفلام
    } catch (error) {
      emit(MovieError(error.toString())); // إصدار حالة error في حالة حدوث مشكلة
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
