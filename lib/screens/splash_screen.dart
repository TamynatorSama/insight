import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:insight1/logic/connectivity.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:insight1/logic/state.dart';
import 'package:insight1/main.dart';
import 'package:insight1/models/setting_model.dart';
import 'package:insight1/reusable/text_placeholder.dart';
import 'package:insight1/tabs/settings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? set;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    set = await SharedPreferences.getInstance();
    Future.delayed(
        const Duration(seconds: 2),
        () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MultiProvider(
                              providers: [
                                ChangeNotifierProvider<SettingsHandler>(
                                  create: (_) => SettingsHandler(),
                                  child: const Settings(),
                                ),
                                ChangeNotifierProvider<SettingsHandler>(
                                  create: (_) => SettingsHandler(),
                                  child: const SplashScreen(),
                                ),
                                ChangeNotifierProvider<StateManager>(
                                  create: (_) => StateManager(),
                                  child: const MyHomePage(),
                                ),
                                ChangeNotifierProvider<ConnectivityA>(
                                  create: (_) => ConnectivityA(),
                                  child: const MyHomePage(),
                                )
                              ],
                              // child: const SplashScreen(),
                              child: const MyHomePage())))
            });
    SettingsModel helpMode;
    if (set!.getString("settings") == null) {
      helpMode = SettingsModel(
          fontColor: Colors.white,
          accentColor: const Color(0xffFFF600),
          background: const Color(0xff303030),
          fontFamilyUse: "whiteny");
          // ignore: use_build_context_synchronously
          Provider.of<SettingsHandler>(context, listen: false).setThemeMode(helpMode);
    } else {
      var help = jsonDecode(set!.getString("settings")!);

      helpMode = SettingsModel(
          fontColor: Color(int.parse(help["fontColor"])),
          accentColor: Color(int.parse(help["accentColor"])),
          background: Color(int.parse(help["background"])),
          fontFamilyUse: help["fontFamilyUse"]);
          // ignore: use_build_context_synchronously
          Provider.of<SettingsHandler>(context, listen: false).setThemeMode(helpMode);
    }

    // var theme = SettingsModel.fromJson(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<SettingsHandler>(context).mode;
    return Scaffold(
      backgroundColor: theme.background,
      body: Center(child: TextPlace(color: theme.fontColor, text: "INSIGHT")),
    );
  }
}
