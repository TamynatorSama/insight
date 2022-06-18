class Movie {
  final String id;
  final String posterpath;
  final String title;
  final String voteaverage;

  Movie(
      {required this.id,
      required this.posterpath,
      required this.title,
      required this.voteaverage});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json["id"],
        posterpath:json["poster_path"],
        title: json["title"],
        voteaverage: json["vote_average"]
        );
  }
}
