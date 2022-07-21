class SearchModel {
  final int id;
  final String image;
  final String title;
  final String type;
  SearchModel({required this.id,required this.image, required this.title, required this.type});

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
        id: json["id"] ,image: json["poster_path"].toString(), title: json["title"].toString(), type: json["media_type"]);
  }
}
