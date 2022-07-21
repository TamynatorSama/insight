import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:insight1/logic/state.dart';
import 'package:insight1/reusable/moviecard.dart';
import 'package:insight1/reusable/moviecardplace.dart';
import 'package:insight1/reusable/placeholder.dart';
import 'package:insight1/reusable/stars.dart';
import 'package:insight1/screens/details.dart';
import 'package:provider/provider.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> refresh() {
    var test =
        Provider.of<StateManager>(context, listen: false).populateCarousel();
    Provider.of<StateManager>(context, listen: false).populateTreanding();
    return test;
  }
  //28841

  @override
  Widget build(BuildContext context) {
    var themeMode = Provider.of<SettingsHandler>(context).mode;

    return RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(child: SizedBox(
          child: Consumer<StateManager>(builder: (context, list, child) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  list.carousel.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: AspectRatio(
                              aspectRatio: 20 / 14,
                              child: ContentPlaceHolder(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                              )),
                        )
                      : CarouselSlider.builder(
                          itemCount: list.carousel.length,
                          itemBuilder: (context, int valve, int nxt) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MultiProvider(
                                              providers: [
                                                ChangeNotifierProvider<
                                                    StateManager>(
                                                  create: (context) =>
                                                      StateManager(),
                                                  child: Details(
                                                      fontColor:
                                                          themeMode.fontColor,
                                                      background:
                                                          themeMode.background,
                                                      color:
                                                          themeMode.accentColor,
                                                      id: list.carousel[valve]
                                                          ["id"]),
                                                ),
                                                ChangeNotifierProvider<
                                                    SettingsHandler>(
                                                  create: (context) =>
                                                      SettingsHandler(),
                                                  child: Details(
                                                      fontColor:
                                                          themeMode.fontColor,
                                                      background:
                                                          themeMode.background,
                                                      color:
                                                          themeMode.accentColor,
                                                      id: list.carousel[valve]
                                                          ["id"]),
                                                ),
                                              ],
                                              child: Details(
                                                  fontColor:
                                                      themeMode.fontColor,
                                                  background:
                                                      themeMode.background,
                                                  color: themeMode.accentColor,
                                                  id: list.carousel[valve]
                                                      ["id"]),
                                            )));
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.35),
                                            BlendMode.darken),
                                        image: CachedNetworkImageProvider(
                                            "https://image.tmdb.org/t/p/w500/${list.carousel[valve]["poster_path"]}"),
                                        fit: BoxFit.cover)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        list.carousel[valve]["title"],
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.85),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24),
                                      ),
                                      Star(
                                          starts: list.carousel[valve]
                                              ["vote_average"]),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                              viewportFraction: 0.92,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 20 / 14,
                              autoPlayCurve: Curves.ease),
                        ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              "Trending",
                              style: TextStyle(
                                  fontSize:
                                      themeMode.fontFamilyUse == "stalinist"
                                          ? 24
                                          : 32,
                                  fontFamily: themeMode.fontFamilyUse,
                                  fontWeight: FontWeight.w600,
                                  color: themeMode.fontColor),
                            ),
                          ),
                          FittedBox(
                            child: Text("See all",
                                style: TextStyle(
                                    color: themeMode.fontColor,
                                    fontFamily: themeMode.fontFamilyUse,
                                    fontSize:
                                        themeMode.fontFamilyUse == "stalinist"
                                            ? 10
                                            : 14,
                                    fontWeight: FontWeight.w500)),
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: list.treading.isEmpty
                            ? Row(
                                children: List.generate(
                                    5, (index) => const MovieCardPlace()))
                            : Row(
                                children: List.generate(
                                list.treading.length,
                                (index) => GestureDetector(
                                  child: MovieCard(
                                    poster: list.treading[index]
                                            ["poster_path"] ??
                                        "https://www.bastiaanmulder.nl/wp-content/uploads/2013/11/dummy-image-square.jpg",
                                    title: list.treading[index]["title"],
                                    rate: list.treading[index]["vote_average"],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MultiProvider(
                                                  providers: [
                                                    ChangeNotifierProvider<
                                                        StateManager>(
                                                      create: (context) =>
                                                          StateManager(),
                                                      child: Details(
                                                          fontColor: themeMode
                                                              .fontColor,
                                                          background: themeMode
                                                              .background,
                                                          color: themeMode
                                                              .accentColor,
                                                          id: list.treading[
                                                              index]["id"]),
                                                    ),
                                                    ChangeNotifierProvider<
                                                        SettingsHandler>(
                                                      create: (context) =>
                                                          SettingsHandler(),
                                                      child: Details(
                                                          fontColor: themeMode
                                                              .fontColor,
                                                          background: themeMode
                                                              .background,
                                                          color: themeMode
                                                              .accentColor,
                                                          id: list.treading[
                                                              index]["id"]),
                                                    ),
                                                  ],
                                                  child: Details(
                                                      fontColor:
                                                          themeMode.fontColor,
                                                      background:
                                                          themeMode.background,
                                                      color:
                                                          themeMode.accentColor,
                                                      id: list.treading[index]
                                                          ["id"]),
                                                )));
                                  },
                                ),
                              )))
                  ]),
                ]);
          }),
        )));
  }
}
