import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:insight1/logic/state.dart';
import 'package:insight1/reusable/moviecard.dart';
import 'package:insight1/reusable/moviecardplace.dart';
import 'package:insight1/reusable/placeholder.dart';
import 'package:insight1/reusable/stars.dart';
import 'package:insight1/screens/series_details.dart';
import 'package:provider/provider.dart';

class SeriesScreen extends StatefulWidget {
  const SeriesScreen({Key? key}) : super(key: key);

  @override
  State<SeriesScreen> createState() => _SeriesScreenState();
}

class _SeriesScreenState extends State<SeriesScreen> {
  @override
  void initState() {
    Provider.of<StateManager>(context, listen: false).populatePopularSeries();
    Provider.of<StateManager>(context, listen: false).populatePlayingSeries();
    super.initState();
  }
  Future<void> refresh() {
    var test = Provider.of<StateManager>(context, listen: false).populatePopularSeries();
    Provider.of<StateManager>(context, listen: false).populatePlayingSeries();
    return test;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
      child: SizedBox(
        child: Consumer<StateManager>(builder: (context, list, child) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                list.playingSeries.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: AspectRatio(
                            aspectRatio: 20 / 14,
                            child: ContentPlaceHolder(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                            )),
                      )
                    : CarouselSlider.builder(
                        itemCount: list.playingSeries.length,
                        itemBuilder: (context, int valve, int nxt) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ChangeNotifierProvider<StateManager>(
                                            create: (_) => StateManager(),
                                            child: SeriesDetails(
                                                id: list.playingSeries[valve].id,pics: list.playingSeries[valve].posterPath,),
                                          )));
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 0),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.35),
                                          BlendMode.darken),
                                      image: CachedNetworkImageProvider(
                                          "https://image.tmdb.org/t/p/w500/${list.playingSeries[valve].posterPath}"),
                                      fit: BoxFit.cover)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      list.playingSeries[valve].name,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.85),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24),
                                    ),
                                    Star(
                                        starts: list.playingSeries[valve].rating),
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
                      children: const [
                        Text(
                          "Trending",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text("See all",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: list.popularSeries.isEmpty
                          ? Row(
                              children: List.generate(
                                  5, (index) => const MovieCardPlace()))
                          : Row(
                              children: List.generate(
                              list.popularSeries.length,
                              (index) => GestureDetector(
                                child: MovieCard(
                                  poster: list
                                          .popularSeries[index].posterPath,
                                  title: list.popularSeries[index].name,
                                  rate: list.popularSeries[index].rating,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              ChangeNotifierProvider<
                                                  StateManager>(
                                                create: (_) => StateManager(),
                                                child: SeriesDetails(
                                                  id: list
                                                      .popularSeries[index].id,
                                                      pics:list
                                          .popularSeries[index].posterPath,
                                                ),
                                              )));
                                },
                              ),
                            )))
                ])
              ]);
        }),
      ),
    ));
  }
}
