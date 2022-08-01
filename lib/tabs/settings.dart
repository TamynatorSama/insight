import 'package:flutter/material.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences? settings;

  @override
  Widget build(BuildContext context) {
    Color useColor = Provider.of<SettingsHandler>(context).mode.accentColor;
    String theme = Provider.of<SettingsHandler>(context).theme;
    final provide = Provider.of<SettingsHandler>(context);
    Color background = provide.mode.background;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            width: double.maxFinite,
            child: Text(
              "Settings",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: provide.mode.fontColor,
                  fontFamily: provide.mode.fontFamilyUse,
                  fontSize: provide.mode.fontFamilyUse == "stalinist" ? 24 : 35,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Text(
                    "Appearance",
                    style: TextStyle(
                        color: provide.mode.fontColor,
                        fontFamily: provide.mode.fontFamilyUse,
                        fontSize:
                            provide.mode.fontFamilyUse == "stalinist" ? 20 : 30,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 15),
                  color: provide.mode.accentColor,
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                PopupMenuButton<Widget>(
                  position: PopupMenuPosition.values[1],
                  color: background,
                  tooltip: "themes",
                  offset: Offset(MediaQuery.of(context).size.width*0.5, 0),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                        child: StatefulBuilder(builder: (context, setState) {
                      return Column(
                        children: [
                          Material(
                            color: provide.mode.background,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Default",
                                    style: TextStyle(
                                        fontFamily: provide.mode.fontFamilyUse,
                                        color: provide.mode.fontColor,
                                        fontSize: 16)),
                                Radio(
                                    value: "darkmode",
                                    groupValue: theme,
                                    onChanged: (String? value) {
                                      provide.themeChange(value,settings);
                                      setState(() {
                                        useColor = provide.mode.accentColor;
                                        theme = provide.theme;
                                        background = provide.mode.background;
                                      });
                                    },
                                    activeColor: useColor),
                              ],
                            ),
                          ),
                          Material(
                            color: provide.mode.background,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("White",
                                    style: TextStyle(
                                        fontFamily: provide.mode.fontFamilyUse,
                                        color: provide.mode.fontColor,
                                        fontSize: 16)),
                                Radio(
                                    value: "whitemode",
                                    groupValue: theme,
                                    onChanged: (String? value) {
                                      provide.themeChange(value,settings);
                                      setState;
                                      setState(() {
                                        useColor = provide.mode.accentColor;
                                        theme = provide.theme;
                                        background = provide.mode.background;
                                      });
                                    },
                                    activeColor: useColor),
                              ],
                            ),
                          ),
                          Material(
                            color: provide.mode.background,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Retro",
                                    style: TextStyle(
                                        fontFamily: provide.mode.fontFamilyUse,
                                        color: provide.mode.fontColor,
                                        fontSize: 16)),
                                Radio(
                                    value: "retromode",
                                    groupValue: theme,
                                    onChanged: (String? value) {
                                      provide.themeChange(value,settings);
                                      setState(() {
                                        useColor = provide.mode.accentColor;
                                        theme = provide.theme;
                                        background = provide.mode.background;
                                      });
                                    },
                                    activeColor: useColor),
                              ],
                            ),
                          )
                        ],
                      );
                    }))
                  ],
                  child: ListTile(
                      leading: Text("Theme",
                          style: TextStyle(
                              color: provide.mode.fontColor,
                              fontFamily: provide.mode.fontFamilyUse,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: provide.mode.fontColor,
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
