import '../../data/models/model.dart';

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  late final List<Movie> favorites;
  FavoriteLoaded(this.favorites);
}

class FavoritesError extends FavoriteState {
  final String message;
  FavoritesError(this.message);
}
