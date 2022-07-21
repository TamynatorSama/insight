import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:insight1/models/watch_list.dart';
import 'package:insight1/reusable/text_placeholder.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  SharedPreferences? watch;
  List useList = [];

  @override
  void initState() {
    instantialte();
    super.initState();
  }

  instantialte() async {
    watch = await SharedPreferences.getInstance();
    var list = jsonDecode(watch!.getStringList("watchList").toString()) as List;
    var parsed = list.map<WatchList>((e) => WatchList.fromJson(e)).toList();

    setState(() {
      useList = parsed;
    });
  }

  @override
  Widget build(BuildContext context) {

    
    var themeMode = Provider.of<SettingsHandler>(context).mode;
  
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child:useList.isNotEmpty
        ? GridView.builder(
            itemCount: useList.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 16 / 15,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(File(useList[index].posterPath)),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10,0,5,5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(useList[index].title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w700),))
                        ],
                      ),
                      ),
                  ],
              );
            },
          )
        : Center(
            child: TextPlace(
              color: themeMode.fontColor,
              text: "your watchlist is empty",
            ),
        )
          );
  }
}
