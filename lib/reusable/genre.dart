import 'package:flutter/material.dart';
import 'package:insight1/logic/settings_handler.dart';
class Genre extends StatelessWidget {
  final String genre;
  const Genre({Key? key, required this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var settings = SettingsHandler();
    return Container(
      alignment: Alignment.center,
      height: 35,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: settings.accentColor, width: 2)),
      child: Text(
        genre,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      ),
    );
  }
}
