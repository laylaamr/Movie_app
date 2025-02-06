import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubitFiles/cubitMovie.dart';
import '../cubitFiles/movieState.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          // Search field if you plan to implement it later
          TextField(
            onChanged: (query) {
              // Future implementation for search (optional)
            },
            decoration: InputDecoration(
              hintText: "Search...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey,
              prefixIcon: Icon(Icons.search),
            ),
          ),
          BlocBuilder<CubitMovie, MovieState>(
            builder: (context, state) {
              if (state is MovieLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MovieError) {
                return Center(child: Text(state.message));
              } else if (state is MovieLoaded) {
                return MovieList(movies: state.movies, isFavoriteScreen: false);
              } else {
                return const Center(child: Text('No Data Available'));
              }
            },
          ),
        ],
      ),
    );
  }
}

