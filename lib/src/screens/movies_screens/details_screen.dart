import 'package:flutter/material.dart';
import 'package:practica2/src/Network/api_cast.dart';
import 'package:practica2/src/Network/api_video.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/cast_movie_model.dart';
import 'package:practica2/src/models/popular_movie_model.dart';
import 'package:practica2/src/models/video_model.dart';
import 'package:practica2/src/screens/movies_screens/popular_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:practica2/src/views/card_cast.dart';
import 'package:practica2/src/widgets/video_player_widget.dart';

class DetailsScreen extends StatefulWidget {
  
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late DatabaseHelper _databaseHelper;
  ApiVideoMovie? apiVideoMovie;
  ApiMovieCast? apiMovieCast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiVideoMovie = ApiVideoMovie();
    apiMovieCast = ApiMovieCast();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    
    final movie = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    bool _pinned = true;
    bool _snap = true;
    bool _floating = true;

    return Scaffold(
      backgroundColor: ColorSetting.bgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight:260,
            backgroundColor: Colors.brown,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: movie['id'].toString(), 
                child:
                FutureBuilder(
                  future: apiVideoMovie?.getMovieTrailer(movie['id'].toString()),
                  builder: (BuildContext context, AsyncSnapshot<VideoMovieModel?> snapshot){
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Error al cargar los datos"),
                      );
                    } else {
                      if (snapshot.hasData) {
                        return VideoPlayerWidget(trailer: snapshot.data!);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  } 
                ), 
              )
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(left:10, right: 10, top: 8.0),
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/loader.gif'), 
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${movie['backdrop_path']}'
                        ),
                        fadeInDuration: Duration(milliseconds: 200),
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.movie),
                        title: Text(movie['title']),
                      ),
                      ListTile(
                        leading: Icon(Icons.star),
                        title: Text(movie['vote_average'].toString()),
                        trailing: FutureBuilder(
                          future: _databaseHelper.seekInFavorites(movie['id']),
                          builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("Error al cargar los datos"),
                              );
                            } else {
                              if (snapshot.connectionState == ConnectionState.done) {
                                return InkWell(
                                  onTap: (){
                                    if (snapshot.data!) {
                                      _databaseHelper.removeFromFavorites(movie['id']);                                                                            
                                    } else {
                                      PopularMoviesModel favoriteMovie = PopularMoviesModel(
                                        backdropPath: movie['backdrop_path'],
                                        id: movie['id'],
                                        originalLanguage: movie['original_language'],
                                        originalTitle: movie['original_title'],
                                        overview: movie['overview'],
                                        popularity: movie['popularity'],
                                        posterPath: movie['poster_path'],
                                        title: movie['title'],
                                        voteAverage: movie['vote_average'],
                                      );
                                      _databaseHelper.addToFavorites(favoriteMovie.toMap());
                                    } 
                                    setState(() {});
                                    movie['update']();

                                  },
                                  child: snapshot.data!? Icon(Icons.favorite, color: Colors.red): Icon(Icons.favorite_border)
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ListTile(
                          title: Center(
                            child: Text("Sinopsis"),
                          ),
                          subtitle: Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 5),
                                const Divider(
                                  height: 10,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                ),
                                const SizedBox(height: 5,),
                                Text(movie['overview'], style: TextStyle(fontSize: 15),),
                                const SizedBox(height: 5,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ),
                SizedBox(
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: FutureBuilder(
                      future: apiMovieCast?.getMovieCast(movie['id']),
                      builder: (BuildContext context, AsyncSnapshot<List<CastMovieModel>?> snapshot){
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error al cargar los datos"),
                          );
                        } else {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return _movieCastBuilder(snapshot.data!);
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }
                      }
                    ),
                  ),
                ),
                SizedBox(height: 15,),
              ]
            ),
          )
        ],
      ),
    );
  }
}

Widget _movieCastBuilder(List<CastMovieModel>? data){
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index){
      CastMovieModel cast = data![index];
      return SizedBox(
        width: 150,
        child: CardMovieCastView(cast: cast)
      );
    },
    itemCount: data!.length,
  );
}