class VideoModel {
  final String title;
  final String imagePath;
  final List<Video> video;

  VideoModel({required this.title,required this.imagePath, required this.video});
  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
        title: json["title"].toString(),
        imagePath: json["image"].toString(),
        video: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))));
  }
}

class Video {
  final String quality;
  final String mimeType;
  final String extensionvid;
  final String url;

  Video(
      {required this.quality,
      required this.mimeType,
      required this.extensionvid,
      required this.url});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        quality: json["quality"],
        mimeType: json["mimeType"],
        extensionvid: json["extension"],
        url: json["url"]);
  }
}
