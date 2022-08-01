import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insight1/models/setting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsHandler extends ChangeNotifier {
  Color accentColor = const Color(0xffFFF600);
  Color backgroundColor = const Color(0xff303030);
  String changeColor = 'default';
  String theme = "darkmode";

  SettingsModel mode = SettingsModel(
      fontColor: Colors.white,
      accentColor: const Color(0xffFFF600),
      background: const Color(0xff303030),
      fontFamilyUse: "whiteny",
      addedColor: "black");

  //theme change function
  themeChange(Object? themeR, SharedPreferences? set) async {
    var set = await SharedPreferences.getInstance();
    switch (themeR) {
      case "darkmode":
        mode = SettingsModel(
            fontColor: Colors.white,
            accentColor: const Color(0xffFFF600),
            background: const Color(0xff303030),
            addedColor: "black",
            fontFamilyUse: "whiteny");
        notifyListeners();
        break;
      case "whitemode":
        mode = SettingsModel(
            fontColor: Colors.black,
            accentColor: Colors.purple,
            background: Colors.white,
            addedColor: "white",
            fontFamilyUse: "whiteny");
        notifyListeners();
        break;
      case "retromode":
        mode = SettingsModel(
            fontColor: Colors.white,
            accentColor: Colors.white,
            background: const Color(0xff303030),
            addedColor: "black",
            fontFamilyUse: "stalinist");
        notifyListeners();
        break;
    }
    theme = themeR.toString();
    try {
      var real = jsonEncode({
        "fontColor": (mode.fontColor.value).toString(),
        "accentColor": (mode.accentColor.value).toString(),
        "background": (mode.background.value).toString(),
        "addedColor": null,
        "fontFamilyUse": mode.fontFamilyUse
      });
      await set.setString("settings", real);
    } catch (e) {
      print(e);
    }

    notifyListeners();
  }

  accentColorChange(Object? value) {
    switch (value) {
      case "default":
        accentColor = const Color(0xFFFFF600);
        changeColor = value.toString();
        break;
      case "teal":
        accentColor = const Color.fromARGB(255, 36, 255, 160);
        changeColor = value.toString();
        break;
      case "white":
        accentColor = Colors.white;
        changeColor = value.toString();
        break;
    }
    notifyListeners();
  }

  setThemeMode(SettingsModel theme) {
    mode = theme;
    notifyListeners();
  }
}
