import 'package:flutter/material.dart';
import 'package:practica2/src/Network/api_popular.dart';
import 'package:practica2/src/models/popular_movie_model.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreen createState() => _PopularScreen();
}

class _PopularScreen extends State<PopularScreen> {
  Api? apiPopular;

  @override
  void initState() {
    super.initState();
    apiPopular = Api();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiPopular!.getAllPopular(),
        builder: (BuildContext context,
            AsyncSnapshot<List<PopularMoviesModel>?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listPopularMovies(snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        });
  }

  Widget _listPopularMovies(List<PopularMoviesModel>? data) {
    return ListView.separated(
      itemBuilder: (context, index) {
        PopularMoviesModel popularMoviesList = data![index];
        // return CardPopularView(popularMoviesList);
        return Container(
          child: Text("test"),
        );
      },
      separatorBuilder: (_, __) => Divider(
        height: 10,
      ),
      itemCount: data!.length,
    );
  }
}
