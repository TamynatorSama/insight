import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:insight1/reusable/stars.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  final String poster;
  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final rate;
  const MovieCard(
      {Key? key, required this.poster, required this.title, this.rate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeMode = Provider.of<SettingsHandler>(context).mode;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 13, 0, 8),
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          poster ==
                                  "https://www.bastiaanmulder.nl/wp-content/uploads/2013/11/dummy-image-square.jpg"
                              ? "https://www.bastiaanmulder.nl/wp-content/uploads/2013/11/dummy-image-square.jpg"
                              : "https://image.tmdb.org/t/p/w500/$poster",
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Text(
                  title,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: themeMode.fontColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Star(starts: rate)
            ],
          )
        ],
      ),
    );
  }
}
