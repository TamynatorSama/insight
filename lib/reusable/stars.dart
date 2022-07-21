import 'package:flutter/material.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:provider/provider.dart';

class Star extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final starts;
  const Star({Key? key, required this.starts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var themeMode = Provider.of<SettingsHandler>(context).mode;
    int num1 = ((starts / 10) * 5).floor();

    Widget _ratingStar(int rate) {
      var start = <Widget>[];
      for (var i = 1; i <= 5; i++) {
        var color =
            i <= rate ? themeMode.accentColor : Colors.white.withOpacity(0.8);
        var stat = Icon(
          i <= rate ? Icons.star : Icons.star_border,
          color: color,
          size: 18,
        );
        start.add(stat);
      }
      return Row(children: start);
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 12), child: _ratingStar(num1));
  }
}
