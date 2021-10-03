// Generated by https://quicktype.io

class PopularMoviesModel {
  PopularMoviesModel({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  String? backdropPath;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  int? voteAverage;
  int? voteCount;

  factory PopularMoviesModel.fromMap(Map<String, dynamic> map) {
    return PopularMoviesModel(
      backdropPath: map['backdrop_path'],
      id: map['id'],
      originalLanguage: map['original_language'],
      originalTitle: map['original_title'],
      overview: map['overview'],
      popularity: map['popularity'],
      posterPath: map['poster_path'],
      releaseDate: DateTime.parse(map['release_date']),
      title: map['title'],
      voteAverage: map['vote_average'],
      voteCount: map['vote_count'],
    );
  }
}
