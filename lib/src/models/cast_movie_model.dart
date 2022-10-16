class CastMovieModel {
  CastMovieModel({
    this.id,
    this.name,
    this.character,
    this.profilePath,
  });
  int? id;
  String? name;
  String? character;
  String? profilePath;

  factory CastMovieModel.fromMap(Map<String, dynamic> map){
    return CastMovieModel(
      id: map['id'],
      name: map['name'],
      character: map['character'],
      profilePath: map['profile_path'],
    );
  }
}