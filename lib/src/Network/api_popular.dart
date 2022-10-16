import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practica2/src/models/popular_movie_model.dart';

class Api {
  var URL = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=b3ba83eef81c1a26d895afeb4bd6ec6d&language=es-MX&page=1');

  Future<List<PopularMoviesModel>?> getAllPopularMovies() async {
    final response = await http.get(URL);

    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularMoviesModel> listPopular =
          popular.map((movie) => PopularMoviesModel.fromMap(movie)).toList();
      return listPopular;
    } else {
      return null;
    }
  }
}
