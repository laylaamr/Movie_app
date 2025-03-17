import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled122222/core/theming/color_manager.dart';
import 'package:untitled122222/core/theming/textstyle_manager.dart';
import 'package:untitled122222/features/Ui/widgets/search_textfield.dart';

import '../../logic/cubitFiles/cubitMovie.dart';
import '../../logic/cubitFiles/movieState.dart';
import '../widgets/genre_list.dart';
import '../widgets/movieCard.dart';

// class HomeScreen extends StatelessWidget {
//   get onChanged => null;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//             TextField(
//             onChanged: onChanged,
//             decoration: InputDecoration(
//               hintText: "Search...",
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(30),
//                 borderSide: BorderSide.none,
//               ),
//               filled: true,
//               fillColor: Colors.grey,
//               prefixIcon: Icon(Icons.search),
//             ),
//           )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // Import the MovieList widget
class HomeScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi 👋🏻",
                        style: TextStyleManager.black30SemiboldRoboto,
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Text(
                        "Experience the Eternity",
                        style: TextStyleManager.grey18ReglarRoboto,
                      ),
                    ],
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://t4.ftcdn.net/jpg/02/79/66/93/360_F_279669366_Lk12QalYQKMczLEa4ySjhaLtx1M2u7e6.jpg'),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 40.sp,
              ),
              SizedBox(
                  width: double.infinity,
                  child: SearchTextfield(controller: _searchController)),
              SizedBox(
                height: 15.sp,
              ),
              BlocBuilder<CubitMovie, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoaded) {
                    final genres = state.movies
                        .expand((movie) => movie.genre)
                        .toSet()
                        .toList(); // تجميع الـ genres بدون تكرار

                    return GenreListView(genres: genres);
                  } else if (state is MovieLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Text("Failed to load genres");
                  }
                },
              ),
              SizedBox(
                height: 15.sp,
              ),
              BlocBuilder<CubitMovie, MovieState>(
                builder: (context, state) {
                  if (state is MovieLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MovieError) {
                    return Center(child: Text(state.message));
                  } else if (state is MovieLoaded) {
                    return MovieList(
                        movies: state.movies, isFavoriteScreen: false);
                  } else {
                    return const Center(child: Text('No Data Available'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
