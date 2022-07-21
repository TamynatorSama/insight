import 'package:flutter/material.dart';

class SettingsModel {
  final Color accentColor;
  final Color background;
  final Color fontColor;
  final String fontFamilyUse;
  final String? addedColor;
  SettingsModel(
      {
        this.addedColor,
      required this.fontColor,
      required this.accentColor,
      required this.background,
      required this.fontFamilyUse});

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      addedColor: json["addedColor"],
        accentColor: json["accentColor"],
        background: json["background"],
        fontColor: json["fontColor"],
        fontFamilyUse: json["fontFamilyUse"]);
  }
  Map<String, dynamic> tojson() => {
        "accentColor": accentColor,
        "background": background,
        "fontFamilyUse": fontFamilyUse
      };
}
