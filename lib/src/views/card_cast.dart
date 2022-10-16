import 'package:flutter/material.dart';
import 'package:practica2/src/models/cast_movie_model.dart';

class CardMovieCastView extends StatelessWidget {
  final CastMovieModel cast;
  const CardMovieCastView({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 150,
            child: cast.profilePath != null?
            CircleAvatar(
              foregroundImage: NetworkImage(
                'https://image.tmdb.org/t/p/w500/${cast.profilePath}',
              ),
            ):
            Container(
              color: Colors.grey[100],
              child: SizedBox(
                height: 100,
                width: 150,
                child: 
                  Icon(Icons.person_sharp)
              ),
            )
          ),
          ListTile(
            title: Text(cast.name!),
            subtitle: Text(cast.character!),
          )
        ],
      ),
    );
  }
}