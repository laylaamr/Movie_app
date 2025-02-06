import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled122222/widgets/movieCard.dart';

import '../Api/model.dart';
import '../cubitFiles/favoriteCubit.dart';
import '../cubitFiles/favotite state.dart';
class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoritesError) {
            return Center(child: Text(state.message));
          } else if (state is FavoriteLoaded) {
            return MovieList(
              movies: state.favorites,
              isFavoriteScreen: true,
            );
          } else {
            return const Center(child: Text('No Data Available'));
          }
        },
      ),
    );
  }
}

