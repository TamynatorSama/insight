import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:insight1/logic/state.dart';
import 'package:insight1/models/sereis_details_model.dart';
import 'package:insight1/models/series_episodes.dart';
import 'package:insight1/reusable/artist.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeriesEpisodeDetails extends StatefulWidget {
  final int id;
  final int epidodeNum;
  final String pics;
  final Color fontColor;
  final Color color;
  final Color background;
  final SeriesEpisodeModel episode;
  const SeriesEpisodeDetails(
      {Key? key,
      required this.episode,
      required this.epidodeNum,
      required this.fontColor,
      required this.color,
      required this.background,
      required this.id,
      required this.pics})
      : super(key: key);

  @override
  State<SeriesEpisodeDetails> createState() => _SeriesEpisodeDetailsState();
}

class _SeriesEpisodeDetailsState extends State<SeriesEpisodeDetails> {
  SharedPreferences? watchlistController;

  SeriesDetailsModel? watchlist;
  @override
  void initState() {
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
        backgroundColor: widget.background,
        body: Consumer<StateManager>(builder: (context, details, child) {
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
                            "https://image.tmdb.org/t/p/w500/${widget.episode.stillPath}"),
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
                              widget.background.withOpacity(0.1),
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
                              widget.episode.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Rate(
                                  color: widget.color,
                                  text: widget.episode.runtime == "null" ? "0" :
                                  widget.episode.runtime.contains(",") ? "${(int.parse(widget.episode.runtime.split(",")[0].replaceAll("[", "")) ~/ 60) == 0 ? "":"${int.parse(widget.episode.runtime.split(",")[0].replaceAll("[", "")) ~/ 60}hr"} ${int.parse(widget.episode.runtime.split(",")[0].replaceAll("[", "")) % 60}min":
                                      "${(int.parse(widget.episode.runtime.replaceAll("[", "").replaceAll("]", "")) ~/ 60)==0? "":"${(int.parse(widget.episode.runtime.replaceAll("[", "").replaceAll("]", "")) ~/ 60)}"}}${int.parse(widget.episode.runtime.replaceAll("[", "").replaceAll("]", "")) % 60}min",
                                  data: Icons.timer_sharp),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: 1,
                                height: 30,
                                color: Colors.white,
                              ),
                              widget.episode.voteAverage.length > 1
                                  ? Row(
                                      textBaseline: TextBaseline.alphabetic,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Icon(
                                              Icons.star,
                                              color: widget.color,
                                              size: 20,
                                            ),
                                          ),
                                          Text(
                                            widget.episode.voteAverage[0] +
                                                widget.episode.voteAverage[1],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                          Text(widget.episode.voteAverage[2],
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              )),
                                        ])
                                  : Row(
                                      textBaseline: TextBaseline.alphabetic,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5.0),
                                            child: Icon(
                                              Icons.star,
                                              color: widget.color,
                                              size: 20,
                                            ),
                                          ),
                                          Text(
                                            widget.episode.voteAverage[0],
                                            style: TextStyle(
                                                color: widget.fontColor,
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
                                  color: widget.color,
                                  text: widget.episode.airDate,
                                  data: Icons.calendar_today)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Episode ${widget.epidodeNum}",
                          style: TextStyle(
                              color: widget.fontColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.episode.overview,
                          style: TextStyle(
                              color: widget.fontColor,
                              fontSize: 15,
                              height: 1.3),
                        ),
                      ])),
              const SizedBox(
                height: 20,
              ),
              widget.episode.stars.isNotEmpty ?
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                      5,
                      (index) => Artist(
                            cname: widget.episode.stars[index].cname,
                            name: widget.episode.stars[index].name,
                            family: "whitney",
                            image: widget.episode.stars[index].headShot,
                            font: widget.fontColor,
                          )),
                ),
              ):const Offstage()
            ])),
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
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )),
          ]);
        }));
  }
}

class Rate extends StatelessWidget {
  final String text;
  final IconData data;
  final Color color;
  const Rate({
    Key? key,
    required this.color,
    required this.text,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Icon(
        data,
        size: 20,
        color: color,
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
