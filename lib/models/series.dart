class SeriesModel {
  final int id;
  final String name;
  final String posterPath;
  final rating;
  SeriesModel(
      {required this.id,required this.name, required this.posterPath, required this.rating});

  factory SeriesModel.fromJson(Map<String, dynamic> json) {
    return SeriesModel(
        id: json["id"],
        name: json["name"],
        posterPath: json["poster_path"].toString(),
        rating: json["vote_average"]);
  }
}
