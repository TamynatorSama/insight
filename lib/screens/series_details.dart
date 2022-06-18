// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:insight1/logic/state.dart';
import 'package:insight1/models/sereis_details_model.dart';
import 'package:insight1/models/watch_list.dart';
import 'package:insight1/reusable/detailsplaceholder.dart';
import 'package:insight1/reusable/genre.dart';
import 'package:insight1/reusable/moviecard.dart';
import 'package:insight1/reusable/seasons_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SeriesDetails extends StatefulWidget {
  final int id;
  final String pics;
  const SeriesDetails({Key? key, required this.id, required this.pics})
      : super(key: key);

  @override
  State<SeriesDetails> createState() => _SeriesDetailsState();
}

class _SeriesDetailsState extends State<SeriesDetails> {
  SharedPreferences? watchlistController;

  SeriesDetailsModel? watchlist;
  @override
  void initState() {
    Provider.of<StateManager>(context, listen: false)
        .getSeriesDetais(widget.id);
    Provider.of<StateManager>(context, listen: false)
        .getSeriesRecomendation(widget.id);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.top]);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var settings = SettingsHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xff303030),
        body: Consumer<StateManager>(builder: (context, details, child) {
          if (details.model.overview == "" ||
              details.model.title == "" ||
              details.model.posterPath == "") {
            return const DetailsPlaceholder();
          }
          else{
            return Stack(children: [
            SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            "https://image.tmdb.org/t/p/w500/${details.model.posterPath}"),
                        fit: BoxFit.cover),
                  ),
                  child: Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                        border: const Border(
                            bottom: BorderSide(color: Color(0xff303030))),
                        gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.1),
                              const Color(0xff303030)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            width: double.maxFinite,
                            child: Text(
                              details.model.title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Rate(
                                text:
                                    "${(int.parse(details.model.runtime.replaceAll("[", "").replaceAll("]", "")) ~/ 60)}hr ${int.parse(details.model.runtime.replaceAll("[", "").replaceAll("]", "")) % 60}min",
                                data: Icons.timer_sharp),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: 1,
                              height: 30,
                              color: Colors.white,
                            ),
                            details.model.rating.length > 1
                                ? Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Icon(
                                            Icons.star,
                                            color: settings.accentColor,
                                            size: 20,
                                          ),
                                        ),
                                        Text(
                                          // "7.",
                                          details.model.rating[0] +
                                              details.model.rating[1],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        ),
                                        Text(
                                            // "9",
                                            details.model.rating[2],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            )),
                                      ])
                                : Row(
                                    textBaseline: TextBaseline.alphabetic,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5.0),
                                          child: Icon(
                                            Icons.star,
                                            color: settings.accentColor,
                                            size: 20,
                                          ),
                                        ),
                                        Text(
                                          // "7.",
                                          details.model.rating[0],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        )
                                      ]),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: 1,
                              height: 30,
                              color: Colors.white,
                            ),
                            Rate(
                                text: details.model.releasedate,
                                data: Icons.calendar_today)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            details.model.genres.length,
                            (index) =>
                                Genre(genre: details.model.genres[index].name)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      details.model.overview,
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.75), fontSize: 15),
                    )
                  ])),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 10, left: 24),
                child: Text(
                  details.model.numberSeasons > 1 ? "Seasons" : "Season",
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 24, bottom: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        details.model.numberSeasons,
                        (index) => SeasonsCard(
                            title: "Season ${index + 1}",
                            image:
                                "https://image.tmdb.org/t/p/w500/${widget.pics}")),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(bottom: 10, left: 24),
                child: const Text("Recomended Series",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 10, left: 24, bottom: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        details.recomemdedSeries.length,
                        (index) => GestureDetector(child: MovieCard(poster: details.recomemdedSeries[index].posterPath, title: details.recomemdedSeries[index].name,rate:details.recomemdedSeries[index].rating), onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ChangeNotifierProvider<
                                                  StateManager>(
                                                create: (_) => StateManager(),
                                                child: SeriesDetails(
                                                  id: details.recomemdedSeries[index].id,
                                                      pics:details.recomemdedSeries[index].posterPath,
                                                ),
                                              )));
                                },),
                  ),
                ),
              ),
            )])),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08,
                    left: 15,
                    right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color.fromARGB(255, 215, 215, 215),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    InkWell(
                      radius: 10,
                      onTap: () async {
                        watchlistController =
                            await SharedPreferences.getInstance();
                        var sharedList = watchlistController!
                                .getStringList('serieswatchList') ??
                            [];

                        var status = await Permission.storage.request();
                        final externalDir =
                            await getExternalStorageDirectories();
                        if (status.isGranted) {
                          List<String> watchliststring = [];

                          for (var i = 0; i < watchlist!.genres.length; i++) {
                            watchliststring.add(watchlist!.genres[i].name);
                          }
                          var watch = WatchList(
                              id: widget.id,
                              releasedate: details.model.releasedate,
                              runtime: details.model.runtime,
                              rating: details.model.rating,
                              posterPath:
                                  '${externalDir![0].path}${details.model.posterPath}',
                              overview: details.model.overview,
                              genres: watchliststring,
                              title: details.model.title,
                              numberSeason: details.model.numberSeasons);

                          var stringed = json.encode(watch);

                          if (sharedList.contains(stringed)) {
                            showSnack(context, "Already in watchlist");
                          } else {
                            sharedList.add(stringed);

                            try {
                              var response = await http.get(Uri.parse(
                                  'https://image.tmdb.org/t/p/w500/${watchlist!.posterPath}'));

                              var file = File(
                                  "${externalDir[0].path}${watchlist!.posterPath}");

                              file.writeAsBytesSync(response.bodyBytes);

                              showSnack(context, "Added to watchlist");
                            } catch (e) {
                              showSnack(context, "An erroe occured");
                            }
                          }
                          await watchlistController!
                              .setStringList("watchList", sharedList);
                          // fuction for downloading image
                        } else {
                          showSnack(context, "Accept permission!!");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.playlist_add,
                          color: SettingsHandler().accentColor,
                        ),
                      ),
                    )
                  ],
                )),
          ]);
          }
        }));
  }
}

class Rate extends StatelessWidget {
  final String text;
  final IconData data;
  const Rate({
    Key? key,
    required this.text,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Icon(
        data,
        size: 20,
        color: SettingsHandler().accentColor,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      )
    ]);
  }
}

showSnack(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}
