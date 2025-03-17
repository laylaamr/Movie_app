import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/networking/Api/ApiService.dart';
import 'features/Ui/screens/HomeScreen.dart';
import 'features/Ui/screens/favouriteScreen.dart';
import 'features/Ui/screens/profileScreen.dart';
import 'features/Ui/widgets/botton_navigation_bar.dart';
import 'features/logic/cubitFiles/cubitMovie.dart';
import 'features/logic/cubitFiles/cubitRepo.dart';
import 'features/logic/cubitFiles/favoriteCubit.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  CubitMovie(movieRepository: movieRepository)..fetchMovies(),
            ),
            BlocProvider(create: (_) => FavoriteCubit()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          ),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
