import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled122222/Ui/favouriteScreen.dart';
import 'package:untitled122222/Ui/HomeScreen.dart';
import 'package:untitled122222/Ui/profileScreen.dart';
import 'package:untitled122222/cubitFiles/cubitMovie.dart';

import 'Api/ApiService.dart';
import 'cubitFiles/cubitRepo.dart';
import 'cubitFiles/favoriteCubit.dart';

void main() {
  final apiService = ApiService(Dio());
  final movieRepository = MovieRepository(apiService: apiService);

  runApp(MyApp(movieRepository: movieRepository));
}

class MyApp extends StatelessWidget {
  final MovieRepository movieRepository;

  MyApp({required this.movieRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CubitMovie(movieRepository: movieRepository)..fetchMovies(),
        ),
        BlocProvider(create: (_) => FavoriteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomNavigationExample(),
      ),
    );
  }
}

class BottomNavigationExample extends StatefulWidget {
  @override
  _BottomNavigationExampleState createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigationExample> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
