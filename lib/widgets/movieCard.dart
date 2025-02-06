import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled122222/Api/model.dart';

import '../Ui/detailsScreen.dart';
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movie: movie),
                ),
              );
            },
            child:
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 190,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
children: [
  AspectRatio(
    aspectRatio: 1,
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: Image.network(
        movie.bigImage,
        fit: BoxFit.contain,
        width: double.infinity,
      ),
    ),
  ),
 Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 8),
 child: Column(
   crossAxisAlignment: CrossAxisAlignment.start,
   children: [
     Text(
       movie.title,
       style: const TextStyle(
         fontSize: 18,
         fontWeight: FontWeight.bold,
         color: Colors.black,
       ),
       softWrap: true,
     ),
     SizedBox(height: 10,),
     Text("Genre : ${movie.genre.toString()}",  style: const TextStyle(
       fontSize: 15,

       color: Colors.black,
     ),
       softWrap: true,),
     SizedBox(height: 7,),
     Row(
       children: [
         Text("Rank : ${movie.rank.toString()}",  style: const TextStyle(
           fontSize: 15,

           color: Colors.black,
         ),
           softWrap: true,),
         SizedBox(width: 50,),
         IconButton(
           icon: Icon(
             isFav ? Icons.favorite : Icons.favorite_border,
             color: isFav ? Colors.red : Colors.black,
           ),
           onPressed: () {
             context.read<FavoriteCubit>().toggleFavorite(movie);
           },
         ),
       ],
     ),

 ],),
 ))
],

                ),
              )
          //ListTile(
            //   leading: Image.network(movie.bigImage),
            //   title: Text(movie.title),
            //   subtitle: Text('Rank: ${movie.id}'),
            //   trailing: IconButton(
            //     icon: Icon(
            //       isFav ? Icons.favorite : Icons.favorite_border,
            //       color: isFav ? Colors.red : Colors.black,
            //     ),
            //     onPressed: () {
            //       context.read<FavoriteCubit>().toggleFavorite(movie);
            //     },
            //   ),
            // ),
          );
        },
      ),
    );
  }
}


