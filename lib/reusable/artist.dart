import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Artist extends StatelessWidget {
  final String name;
  final String cname;
  final String image;
  final Color font;
  final String family;
  const Artist(
      {Key? key,
      required this.cname,
      required this.name,
      required this.family,
      required this.image,
      required this.font})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left:12),
      width: MediaQuery.of(context).size.width * 0.3,
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            margin: const EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        "https://image.tmdb.org/t/p/w500/$image"))),
          ),
          Column(
            children: [
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(color: font, fontFamily: family, fontSize: 15,fontWeight: FontWeight.w600),
          ),
          Text(
            cname,
            textAlign: TextAlign.center,
            style: TextStyle(color: font.withOpacity(0.8), fontFamily: family, fontSize: 13),
          )
            ],
          )
        ],
      ),
    );
  }
}
