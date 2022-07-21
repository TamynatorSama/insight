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
    Timer.periodic(
        const Duration(seconds: 2),
        (timer) => {
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
    super.initState();
  }

  initialize() async {
    set = await SharedPreferences.getInstance();
    print(set!.get("settings"));
    // var theme = set!.get("settings");
    // var themeMode = jsonDecode(set!.getString("settings")!);

    var theme = SettingsModel.fromJson(jsonDecode(set!.get("settings").toString()));
    // ignore: use_build_context_synchronously
    Provider.of<SettingsHandler>(context, listen: false).setThemeMode(theme);
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
