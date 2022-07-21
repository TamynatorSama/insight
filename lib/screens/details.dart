// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insight1/logic/apicall.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:insight1/logic/state.dart';
import 'package:insight1/models/detail_model.dart';
import 'package:insight1/models/videomodel.dart';
import 'package:insight1/models/watch_list.dart';
import 'package:insight1/reusable/detailsplaceholder.dart';
import 'package:insight1/reusable/genre.dart';
import 'package:insight1/reusable/heropageroute.dart';
import 'package:insight1/reusable/text_placeholder.dart';
import 'package:insight1/reusable/video_player.dart';
import 'package:insight1/reusable/videocard.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  final int id;
  final Color color;
  final Color background;
  final Color fontColor;
  const Details({
    Key? key,
    required this.fontColor,
    required this.color,
    required this.background,
    required this.id,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  VideoPlayerController? _controller;
  SharedPreferences? watchlistController;

  DetailsModel? watchlist;
  @override
  void initState() {
    pop();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  pop() async {
    watchlist = await getdetails();
  }

  Future getdetails() async {
    var videodetails = await HttpReq.request.getdetails(widget.id);
    return videodetails;
  }

  Future<List<VideoModel>> letsgo() async {
    var videoid = await HttpReq.request.videoDetail(widget.id);
    List<VideoModel> test = [];
    for (var i = 0; i < videoid.length; i++) {
      var list = await HttpReq.request.getVideoLink(videoid[i].key);
      test.add(list);
    }
    return test;
  }

  // pop

  var settings = SettingsHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: widget.background,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: FutureBuilder(
                future: getdetails(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    var list = snapshot.data as DetailsModel;
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.55,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        "https://image.tmdb.org/t/p/w500/${list.posterPath}"),
                                    fit: BoxFit.cover),
                              ),
                              child: Container(
                                width: double.maxFinite,
                                height: double.maxFinite,
                                decoration: BoxDecoration(
                                    border: const Border(
                                        bottom: BorderSide(
                                            color: Color(0xff303030))),
                                    gradient: LinearGradient(
                                        colors: [
                                          widget.background.withOpacity(0.1),
                                          const Color(0xff303030)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 12),
                                        width: double.maxFinite,
                                        child: Text(
                                          list.title,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ChangeNotifierProvider(
                                            create: (context) =>
                                                SettingsHandler(),
                                            child: Rate(
                                                useColor: widget.color,
                                                text:list.runtime.contains(",") ? "${(int.parse(list.runtime.split(",")[0].replaceAll("[", "")) ~/ 60) == 0 ? "":"${int.parse(list.runtime.split(",")[0].replaceAll("[", "")) ~/ 60}hr"} ${int.parse(list.runtime.split(",")[0].replaceAll("[", "")) % 60}min":
                                        "${(int.parse(list.runtime.replaceAll("[", "").replaceAll("]", "")) ~/ 60)==0? "":"${(int.parse(list.runtime.replaceAll("[", "").replaceAll("]", "")) ~/ 60)}"}}${int.parse(list.runtime.replaceAll("[", "").replaceAll("]", "")) % 60}min",
                                                data: Icons.timer_sharp),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 1,
                                            height: 30,
                                            color: Colors.white,
                                          ),
                                          list.rating.length > 1
                                              ? Row(
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                right: 5.0),
                                                        child: Icon(
                                                          Icons.star,
                                                          color: widget.color,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        // "7.",
                                                        list.rating[0] +
                                                            list.rating[1],
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontSize: 17),
                                                      ),
                                                      Text(
                                                          // "9",
                                                          list.rating[2],
                                                          style: const TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontSize: 15,
                                                          )),
                                                    ])
                                              : Row(
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                right: 5.0),
                                                        child: Icon(
                                                          Icons.star,
                                                          color: widget.color,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      Text(
                                                        // "7.",
                                                        list.rating[0],
                                                        style: TextStyle(
                                                            color:
                                                                widget.fontColor,
                                                            fontSize: 17),
                                                      )
                                                    ]),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 1,
                                            height: 30,
                                            color: Colors.white,
                                          ),
                                          ChangeNotifierProvider(
                                              create: (context) =>
                                                  SettingsHandler(),
                                              child: Rate(
                                                  useColor: widget.color,
                                                  text: list.releasedate,
                                                  data: Icons.calendar_today))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        list.genres.length,
                                        (index) => ChangeNotifierProvider(
                                            create: (context) =>
                                                SettingsHandler(),
                                            child: Genre(
                                              font: widget.fontColor,
                                                color: widget.color,
                                                genre:
                                                    list.genres[index].name))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  list.overview,
                                  style: TextStyle(
                                      color: widget.fontColor, fontSize: 16),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "Videos",
                                    style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w600,
                                        color: widget.fontColor),
                                  ),
                                ),
                                FutureBuilder(
                                    future: letsgo(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        var trailers =
                                            snapshot.data as List<VideoModel>;
                                        return SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(
                                                trailers.length,
                                                (index) => GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .push(HeroPageRoute(
                                                              builder: (_) =>
                                                                  ChangeNotifierProvider<
                                                                      StateManager>(
                                                                    create: (_) =>
                                                                        StateManager(),
                                                                    child:
                                                                        VideoPalyer(
                                                                      model: trailers[
                                                                          index],
                                                                    ),
                                                                  )));
                                                    },
                                                    child: VideoCard(
                                                      font: widget.fontColor,
                                                      image: trailers[index]
                                                          .imagePath,
                                                      title:
                                                          trailers[index].title,
                                                    ))),
                                          ),
                                        );
                                      } else {
                                        return TextPlace(
                                            color: widget.color,
                                            text: "Getting Videos");
                                      }
                                    }),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const DetailsPlaceholder();
                  }
                }),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08,
                    left: 15,
                    right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: widget.fontColor,
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
                        var sharedList =
                            watchlistController!.getStringList('watchList') ??
                                [];

                        var status = await Permission.storage.request();
                        final externalDir =
                            await getExternalStorageDirectories();
                        if (status.isGranted) {
                          List<String> watchliststring = [];

                          for (var i = 0; i < watchlist!.genres.length; i++) {
                            watchliststring.add(watchlist!.genres[i].name);
                          }

                          // watchlist!.genres
                          //     .forEach((e) => {watchliststring.add(e.name)});

                          // encoding to jason and storing in shared preference
                          var watch = WatchList(
                              id: widget.id,
                              releasedate: watchlist!.releasedate,
                              runtime: watchlist!.runtime,
                              rating: watchlist!.rating,
                              posterPath:
                                  '${externalDir![0].path}${watchlist!.posterPath}',
                              overview: watchlist!.overview,
                              genres: watchliststring,
                              title: watchlist!.title);

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
                          color: widget.color,
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}

class Rate extends StatelessWidget {
  final String text;
  final IconData data;
  final Color useColor;
  const Rate(
      {Key? key,
      required this.text,
      required this.data,
      required this.useColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        // textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            data,
            size: 20,
            color: useColor,
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
