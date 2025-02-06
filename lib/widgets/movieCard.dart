import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled122222/Api/model.dart';

import '../cubitFiles/cubitMovie.dart';
import '../cubitFiles/favoriteCubit.dart';
import '../cubitFiles/favotite state.dart';
import '../cubitFiles/movieState.dart';

// class Moviecard extends StatelessWidget {
//    Moviecard({super.key ,required this.movies});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(padding: EdgeInsets.all(5),
//     child: ListView.builder(
//         itemCount: movies.length,
//         itemBuilder: (context ,index){
//           final Movie = movies[index];
//           return InkWell();
//
//         }),
//     );
//   }
// }
// Adjust import path

class MovieList extends StatelessWidget {
  final bool isFavoriteScreen;
  final List<Movie> movies; // List of movies

  const MovieList({
    Key? key,
    required this.isFavoriteScreen,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          final isFav = context.read<FavoriteCubit>().state is FavoriteLoaded
              ? (context.read<FavoriteCubit>().state as FavoriteLoaded)
              .favorites
              .contains(movie)
              : false;
      
          return InkWell(
            onTap: () {
              // Navigate to the detail screen if needed
            },
            child: ListTile(
              leading: Image.network(movie.image),
              title: Text(movie.title),
              subtitle: Text('Rank: ${movie.id}'),
              trailing: IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.black,
                ),
                onPressed: () {
                  // Toggle favorite
                  context.read<FavoriteCubit>().toggleFavorite(movie);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}


