import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled122222/core/theming/textstyle_manager.dart';

import '../../data/models/model.dart';
import '../../logic/cubitFiles/favoriteCubit.dart';
import '../../logic/cubitFiles/favotite state.dart';
import '../screens/detailsScreen.dart';

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
  final List<Movie> movies;

  const MovieList({
    Key? key,
    required this.isFavoriteScreen,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.55,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          final isFav = context.read<FavoriteCubit>().state is FavoriteLoaded
              ? (context.read<FavoriteCubit>().state as FavoriteLoaded)
                  .favorites
                  .contains(movie)
              : false;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movie: movie),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3.sp),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 230.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(movie.bigImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        movie.title,
                        textAlign: TextAlign.center,
                        style: TextStyleManager.grey18ReglarRight,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  // SizedBox(height: 10.sp),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
