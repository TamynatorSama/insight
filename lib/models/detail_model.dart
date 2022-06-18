class DetailsModel {
  final String posterPath;
  final String overview;
  final List<Genres> genres;
  final String title;
  final String rating;
  final String runtime;
  final String releasedate;

  DetailsModel(
      {required this.releasedate,
      required this.runtime,
      required this.rating,
      required this.posterPath,
      required this.overview,
      required this.genres,
      required this.title});
  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
        posterPath: json["poster_path"],
        overview: json["overview"],
        genres:
            List<Genres>.from(json["genres"].map((x) => Genres.fromJson(x))),
        title: json["original_title"],
        rating: json["vote_average"].toString(),
        runtime: json["runtime"].toString(),
        releasedate: json["release_date"]);
  }
}

class Genres {
  final String name;

  Genres({required this.name});
  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(name: json["name"]);
  }
}
