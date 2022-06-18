class SeriesDetailsModel {
  final String posterPath;
  final String overview;
  final List<Genres> genres;
  final String title;
  final String rating;
  final String runtime;
  final String releasedate;
  final int numberSeasons;

  SeriesDetailsModel(
      {required this.releasedate,
      required this.runtime,
      required this.rating,
      required this.posterPath,
      required this.overview,
      required this.genres,
      required this.title,
      required this.numberSeasons
      });
  factory SeriesDetailsModel.fromJson(Map<String, dynamic> json) {
    return SeriesDetailsModel(
        posterPath: json["backdrop_path"],
        overview: json["overview"],
        genres:
            List<Genres>.from(json["genres"].map((x) => Genres.fromJson(x))),
        title: json["original_name"],
        rating: json["vote_average"].toString(),
        runtime: json["episode_run_time"].toString(),
        releasedate: json["first_air_date"],
        numberSeasons: json["number_of_seasons"]
        );
  }
}

class Genres {
  final String name;

  Genres({required this.name});
  factory Genres.fromJson(Map<String, dynamic> json) {
    return Genres(name: json["name"]);
  }
}
