import 'package:flutter/material.dart';

class Genre extends StatelessWidget {
  final String genre;
  final Color color;
  final Color font;
  const Genre({Key? key,required this.font, required this.color, required this.genre})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 35,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2)),
      child: Text(
        genre,
        style:
             TextStyle(color: font, fontWeight: FontWeight.w600),
      ),
    );
  }
}
