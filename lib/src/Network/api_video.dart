import 'dart:convert';

import 'package:practica2/src/models/video_model.dart';
import 'package:http/http.dart' as http;

class ApiVideoMovie {
  Future<VideoMovieModel?> getMovieTrailer(String id) async{
    var URL = Uri.parse(
      'https://api.themoviedb.org/3/movie/$id/videos?api_key=b3ba83eef81c1a26d895afeb4bd6ec6d&language=es-US'
    );
    final response = await http.get(URL);

    if (response.statusCode == 200) {
      var trailer = jsonDecode(response.body);
      print(trailer['results'][0]['key']);
      var test = trailer['results'].where((i)=> i['type'] == 'Trailer').toList();
      print(test[0]);
      VideoMovieModel movieTrailer = VideoMovieModel.fromMap(test[0] ?? trailer['results'][0]);
      return movieTrailer;
    } else {
      return null;
    }
  }
}