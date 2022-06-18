class TrailerModel {
  final String name;
  final String key;
  final String type;

  TrailerModel({required this.name, required this.key, required this.type});
  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
        name: json["name"], key: json["key"], type: json["type"]);
  }
}
