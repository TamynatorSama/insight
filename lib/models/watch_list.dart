class WatchList {
  final int id;
  final String posterPath;
  final String overview;
  final List<String> genres;
  final String title;
  final String rating;
  final String runtime;
  final String releasedate;
  int? numberSeason;

  WatchList(
      {required this.id,
      required this.releasedate,
      required this.runtime,
      required this.rating,
      required this.posterPath,
      required this.overview,
      required this.genres,
      required this.title,
      this.numberSeason});
  factory WatchList.fromJson(Map<String, dynamic> json) {
    return WatchList(
        id: json["id"],
        posterPath: json["posterPath"].toString(),
        overview: json["overview"].toString(),
        genres: List<String>.from(json["genre"].map((x) => x)),
        title: json["title"].toString(),
        rating: json["rating"],
        runtime: json["runtime"].toString(),
        releasedate: json["releasedate"].toString(),
        numberSeason: json['numberSeason']
        );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "posterPath": posterPath,
        "overview": overview,
        "genre": List<dynamic>.from(genres.map((x) => x)),
        "title": title,
        "rating": rating,
        "runtime": runtime,
        "releasedate": releasedate,
        "numberSeason":numberSeason
      };
}
