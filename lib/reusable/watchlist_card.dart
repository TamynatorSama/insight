import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insight1/reusable/stars.dart';

class WatchlistCard extends StatelessWidget {
  final String poster;
  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final rate;
  const WatchlistCard(
      {Key? key, required this.poster, required this.title, this.rate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 13, 0, 8),
                width: MediaQuery.of(context).size.width * 0.35,
                height: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:FileImage(File(poster),),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12)),
              ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.35,
                child: Text(
                  title,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
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
