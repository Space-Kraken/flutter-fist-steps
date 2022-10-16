import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practica2/src/models/popular_movie_model.dart';

class CardCardPopularView extends StatelessWidget {
  final PopularMoviesModel popular;
  final Function? onTap;
  const CardCardPopularView({Key? key, required this.popular, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 2.0, top: 2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              spreadRadius: 2,
              offset: Offset(0.0, 2.0),
              blurRadius: 2.5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                child: Hero(
                  tag: popular.id.toString(),
                  child: FadeInImage(
                  placeholder: AssetImage('assets/loader.gif'),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500/${popular.backdropPath}'),
                  fadeInDuration: Duration(milliseconds: 200),
                  ),
                ),
              ),
              Opacity(
                opacity: 0.5,
                child: Container(
                  padding: EdgeInsets.only(left:10.0, right: 10.0),
                  height: 40.0,
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${popular.title}", style: TextStyle(color: Colors.white, fontSize: 12),),
                      IconButton(
                        onPressed: (){
                          Navigator.pushNamed(
                            context, '/details', 
                            arguments: {
                              'id': popular.id,
                              'title': popular.title,
                              'overview': popular.overview,
                              'backdrop_path':popular.backdropPath,
                              'posterpath': popular.posterPath,
                              'vote_average':popular.voteAverage,
                              'update': onTap
                            }
                          );
                        },
                        icon: Icon(Icons.chevron_right, color: Colors.white,),
                      )
                    ], 
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
