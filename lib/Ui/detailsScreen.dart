import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled122222/Api/model.dart';

import '../cubitFiles/favoriteCubit.dart';
class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {return
    SafeArea(
      child: Scaffold(
        body:
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Stack(
            //  alignment: Alignment.bottomCenter,
            children: [SizedBox(
              child: Image.network(
                movie.bigImage,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
              Positioned(
                 top:  16,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back,
                  size: 25,color: Color(0xFF64B5F6),)))
            ]
          ),
          Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(movie.title, style: TextStyle(fontSize: 20),
                softWrap: true,),
                Row(children: [
                  Icon(Icons.star_rate_outlined, color: Color( 0xFF64B5F6),size: 28,),
                  SizedBox(width: 5,),
                  Text(movie.rating, style: TextStyle(fontSize: 20),),],),
              ],
            ),
            Text("Genre : ${movie.genre}",style: TextStyle(fontSize: 15)),
            SizedBox(height: 10,),
            Text("${movie.description}", style: TextStyle(fontSize: 18),),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: (){},  style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF0D47A1),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
        child: const Center(
          child: Text(
            'Watch Trailer',
            style: TextStyle(fontSize:20),
          ),
        ),),
            SizedBox(width: 10,)
          ],
        ),
          ),
        
        ],),
      )
        ,),
    );
  }
}