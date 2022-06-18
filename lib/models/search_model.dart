class SearchModel {
  final String imdbid;
  final String image;
  final String title;
  final String type;
  SearchModel({required this.imdbid,required this.image, required this.title, required this.type});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
        imdbid: json["imdbid"] ,image: json["poster"], title: json["title"], type: json["type"]);
  }
}
