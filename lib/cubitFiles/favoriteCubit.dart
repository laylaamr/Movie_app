import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled122222/cubitFiles/favotite%20state.dart';
import 'package:untitled122222/database/favorite.dart';

import '../Api/model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance; // instance from DatabaseHelper

  FavoriteCubit() : super(FavoriteInitial());

  Future<void> loadFavorites() async {
    try {
      emit(FavoriteLoading());
      final favorites = await dbHelper.getFavoriteMovies();
      emit(FavoriteLoaded(favorites));
    } catch (e) {
      emit(FavoritesError("Failed to load favorites"));
    }
  }

  // Prevent duplication by using the movie's `rank` instead of `id`
  Future<void> toggleFavorite(Movie movie) async {
    try {
      final isFav = await dbHelper.isFavorite(movie.rank); // Check based on `rank`

      if (isFav) {
        await dbHelper.deleteMovie(movie.rank); // Delete using `rank`
      } else {
        await dbHelper.insertMovie(movie); // Insert movie
      }

      await loadFavorites(); // Reload favorites after the change
    } catch (e) {
      emit(FavoritesError("Error updating favorites: $e"));
    }
  }

  // Check if the movie is already in favorites using `rank`
  Future<bool> isFavorite(int rank) async {
    return await dbHelper.isFavorite(rank);
  }
}
