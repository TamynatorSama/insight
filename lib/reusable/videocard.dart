import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class VideoCard extends StatelessWidget {
  final String image;
  final String title;
  final Color font;
  const VideoCard({Key? key,required this.font, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var themeMode = Provider.of<SettingsHandler>(context).mode;

    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(right: 15),
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.17,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white.withOpacity(0.3),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(image),
                    fit: BoxFit.cover)),
            child: const Icon(
              Icons.play_circle_outline,
              color: Colors.white,
            )),
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            title,
            style: TextStyle(color: font, fontSize: 15),
          ),
        )
      ],
    );
  }
}
