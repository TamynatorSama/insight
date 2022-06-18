import 'package:flutter/material.dart';
import 'package:insight1/reusable/placeholder.dart';
import 'package:insight1/reusable/stars.dart';
import 'package:shimmer/shimmer.dart';

class MovieCardPlace extends StatelessWidget {
  const MovieCardPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ContentPlaceHolder(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.width * 0.35,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.4),
                    highlightColor: Colors.grey.withOpacity(1),
                    child: Container(
                      width: 100,
                      height: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Star(starts: 10),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
