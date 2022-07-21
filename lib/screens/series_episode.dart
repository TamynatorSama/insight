import 'package:flutter/material.dart';
import 'package:insight1/logic/state.dart';
import 'package:insight1/reusable/searchcard.dart';
import 'package:insight1/reusable/text_placeholder.dart';
import 'package:insight1/screens/series_episode_details.dart';
import 'package:provider/provider.dart';

class SeriesEpisode extends StatefulWidget {
  final int id;
  final Color background;
  final Color font;
  final int season;
  const SeriesEpisode(
      {Key? key,
      required this.season,
      required this.background,
      required this.font,
      required this.id})
      : super(key: key);

  @override
  State<SeriesEpisode> createState() => _SeriesEpisodeState();
}

class _SeriesEpisodeState extends State<SeriesEpisode> {
  @override
  void initState() {
    Provider.of<StateManager>(context, listen: false).getEpisodes(widget.id,widget.season);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Consumer<StateManager>(
            builder: (context, value, child) {
              if (value.seriesEpisode.isEmpty) {
                return Center(
                    child: TextPlace(
                        color: widget.font, text: "Getting list of episodes"));
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom:10.0),
                            child: Text("Season ${widget.season}",style: TextStyle(color: widget.font, fontSize: 32,fontWeight: FontWeight.w600),),
                          ),
                          Column(
                    children: List.generate(
                            value.seriesEpisode.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) => ChangeNotifierProvider<
                                                    StateManager>(
                                                create: (_) => StateManager(),
                                                child: SeriesEpisodeDetails(
                                                    episode: value.seriesEpisode[index],
                                                    epidodeNum: index + 1,
                                                    fontColor: widget.font,
                                                    color: Colors.orange,
                                                    background: widget.background,
                                                    id: widget.id,
                                                    pics:
                                                        "https://image.tmdb.org/t/p/w500/${value.seriesEpisode[index].stillPath}"))));
                                  },
                                  child: SearchResult(
                                      font: widget.font,
                                      image:
                                          "https://image.tmdb.org/t/p/w500/${value.seriesEpisode[index].stillPath}",
                                      title: value.seriesEpisode[index].name,
                                      description:
                                          "Episode ${value.seriesEpisode[index].episodeNum}"),
                                )),
                  ),
                        ],
                      )),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
