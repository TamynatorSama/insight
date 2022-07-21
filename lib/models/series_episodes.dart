class SeriesEpisodeModel {
  final String airDate;
  final int episodeNum;
  final String name;
  final String overview;
  final String stillPath;
  final String runtime;
  final String voteAverage;
  final List<GuestStars> stars;
  SeriesEpisodeModel(
      {required this.airDate,
      required this.episodeNum,
      required this.name,
      required this.overview,
      required this.runtime,
      required this.stillPath,
      required this.stars,
      required this.voteAverage});
  factory SeriesEpisodeModel.fromJson(Map<String, dynamic> json) {
    return SeriesEpisodeModel(
        airDate: json['air_date'].toString(),
        episodeNum: json['episode_number'],
        name: json['name'].toString(),
        overview: json['overview'].toString(),
        runtime: json['runtime'].toString(),
        stillPath: json['still_path'].toString(),
        voteAverage: json['vote_average'].toString(),
        stars: List<GuestStars>.from(
            json["guest_stars"].map((x) => GuestStars.fromJson(x))));
  }
}

class GuestStars {
  int id;
  String name;
  String headShot;
  String cname;
  GuestStars({required this.id, required this.cname,required this.name, required this.headShot});
  factory GuestStars.fromJson(Map<String, dynamic> json) {
    return GuestStars(
        id: json["id"],
        name: json["original_name"].toString(),
        cname: json["character"].toString(),
        headShot: json["profile_path"].toString());
  }
}
