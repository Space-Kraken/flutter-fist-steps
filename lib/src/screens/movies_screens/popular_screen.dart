import 'package:flutter/material.dart';
import 'package:practica2/src/Network/api_popular.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/popular_movie_model.dart';
import 'package:practica2/src/views/card_popular.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreen createState() => _PopularScreen();
}

class _PopularScreen extends State<PopularScreen> {
  late DatabaseHelper _databaseHelper;
  Api? apiPopular;
  var tabIndex = 0;

  @override
  void initState() {
    super.initState();
    apiPopular = Api();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {

    void _upDate(){
      setState(() {
        
      });
    }

    final _tabScreens = <Widget>[
      _buildPopularMovies(),
      _buildFavoriteMovies(_upDate),
    ];


    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            tabIndex = index;
          });
        },
        currentIndex: tabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter_rounded),
            label: 'Popular',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favorites',
          ),
        ],
      ),
      appBar: AppBar(title: Text('Movies from API')),
      body: _tabScreens[tabIndex], 
    );
  }

  Widget _buildFavoriteMovies(Function _upDate) {
    return FutureBuilder(
      future: _databaseHelper.getFavoritesMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<PopularMoviesModel>?> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!.length != 0?
              _listPopularMovies(snapshot.data, _upDate):
              Center(
                child: Text('No favorites movies'),
              );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }

  Widget _buildPopularMovies() {
    return FutureBuilder(
      future: apiPopular!.getAllPopularMovies(),
      builder: (BuildContext context, AsyncSnapshot<List<PopularMoviesModel>?> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error'),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return _listPopularMovies(snapshot.data, null);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      }
    );
  }

  Widget _listPopularMovies(List<PopularMoviesModel>? data, Function? _upDate) {
    return ListView.separated(
      itemBuilder: (context, index) {
        PopularMoviesModel popularMoviesList = data![index];
        return CardCardPopularView(popular: popularMoviesList, onTap: _upDate);
      },
      separatorBuilder: (_, __) => Divider(
        height: 10,
      ),
      itemCount: data!.length,
    );
  }
}
