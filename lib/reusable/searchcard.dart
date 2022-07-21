import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final Color font;

  const SearchResult(
      {Key? key,
      required this.image,
      required this.font,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            height: MediaQuery.of(context).size.width * 0.35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(image),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        title.trim(),
                        style: TextStyle(
                            color: font,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      )),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Text(
                      description,
                      style: TextStyle(
                          color: font.withOpacity(0.5), fontSize: 15),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
