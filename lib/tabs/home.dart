import 'package:flutter/material.dart';
import 'package:insight1/logic/connectivity.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:insight1/logic/state.dart';
import 'package:insight1/screens/movies.dart';
import 'package:insight1/screens/search.dart';
import 'package:insight1/screens/series.dart';
import 'package:insight1/screens/watchlist.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<ConnectivityA>(context, listen: false).startMonitoring();
    Provider.of<StateManager>(context, listen: false).populateCarousel();
    Provider.of<StateManager>(context, listen: false).populateTreanding();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List category = ["Movies", "Series", "Watchlist"];

    final List screens = [
      const MoviesScreen(),
      const SeriesScreen(),
      const WatchlistScreen()
    ];

    // Future<void> refresh() async {
    //   Provider.of<StateManager>(context, listen: false).populateCarousel();
    //   Provider.of<StateManager>(context, listen: false).populateTreanding();
    // }

    int selectCat = Provider.of<StateManager>(context).selectCat;
    var settings = SettingsHandler();

    return Padding(
        padding: const EdgeInsets.only(top: 8.0), //use 8.0 for padding
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Column(children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) =>
                                    ChangeNotifierProvider<StateManager>(
                                      create: (_) => StateManager(),
                                      child: const Search(),
                                    )));
                      },
                      child: const Icon(
                        Icons.search_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Category",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          category.length,
                          (index) => GestureDetector(
                            onTap: () {
                              Provider.of<StateManager>(context, listen: false)
                                  .changeCat(index);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              decoration: selectCat == index
                                  ? BoxDecoration(
                                      color: settings.accentColor,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 10,
                                              color: Color(0xffC3C3C3))
                                        ])
                                  : null,
                              child: Text(
                                category[index],
                                style: selectCat == index
                                    ? const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)
                                    : const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      child: PageView.builder(
                        onPageChanged: (value){
                          Provider.of<StateManager>(context, listen: false)
                                  .changeCat(value);
                        },
                          itemCount: screens.length,
                          itemBuilder: ((context, index) {
                            return screens[Provider.of<StateManager>(context).selectCat];
                          }))),
                ],
              ),
            )
          ]),
          Consumer<ConnectivityA>(builder: (context, modal, child) {
            if (modal.isConnected) {
              return const Offstage(
                offstage: true,
              );
            } else {
              return Icon(Icons.wifi_off,
                  color: settings.accentColor, size: 70);
            }
          }),
        ]));

    // return SafeArea(
    //     child: Padding(
    //         padding: const EdgeInsets.only(top: 8.0), //use 8.0 for padding
    //         child: Stack(alignment: AlignmentDirectional.center, children: [
    //           Consumer<ConnectivityA>(builder: (context, modal, child) {
    //             if (modal.isConnected) {
    //               return const Offstage(
    //                 offstage: true,
    //               );
    //             } else {
    //               return Icon(Icons.wifi_off,
    //                   color: settings.accentColor, size: 70);
    //             }
    //           }),
    //           RefreshIndicator(
    //             onRefresh: refresh,
    //             child: SingleChildScrollView(
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.start,
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Container(
    //                     width: MediaQuery.of(context).size.width,
    //                     alignment: Alignment.centerRight,
    //                     padding: const EdgeInsets.symmetric(horizontal: 24),
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         Navigator.push(
    //                             context,
    //                             MaterialPageRoute(
    //                                 builder: (ctx) =>
    //                                     ChangeNotifierProvider<StateManager>(
    //                                       create: (_) => StateManager(),
    //                                       child: const Search(),
    //                                     )));
    //                       },
    //                       child: const Icon(
    //                         Icons.search_rounded,
    //                         size: 30,
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     height: 24,
    //                   ),
    //                   Padding(
    //                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         const Text(
    //                           "Category",
    //                           style: TextStyle(
    //                               fontSize: 32,
    //                               fontWeight: FontWeight.w600,
    //                               color: Colors.white),
    //                         ),
    //                         const SizedBox(
    //                           height: 24,
    //                         ),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                           children: List.generate(
    //                               category.length,
    //                               (index) => GestureDetector(
    //                                     onTap: () {
    //                                       Provider.of<StateManager>(context,
    //                                               listen: false)
    //                                           .changeCat(index);
    //                                     },
    //                                     child: Container(
    //                                       padding: const EdgeInsets.symmetric(
    //                                           vertical: 10, horizontal: 12),
    //                                       decoration: selectCat == index
    //                                           ? BoxDecoration(
    //                                               color: settings.accentColor,
    //                                               borderRadius:
    //                                                   BorderRadius.circular(12),
    //                                               boxShadow: const [
    //                                                   BoxShadow(
    //                                                       blurRadius: 10,
    //                                                       color:
    //                                                           Color(0xffC3C3C3))
    //                                                 ])
    //                                           : null,
    //                                       child: Text(
    //                                         category[index],
    //                                         style: selectCat == index
    //                                             ? const TextStyle(
    //                                                 fontSize: 16,
    //                                                 fontWeight: FontWeight.bold)
    //                                             : const TextStyle(
    //                                                 color: Colors.white,
    //                                                 fontSize: 16,
    //                                                 fontWeight:
    //                                                     FontWeight.bold),
    //                                       ),
    //                                     ),
    //                                   )),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     height: 36,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //           )
    //         ])));
  }
}

// FutureBuilder(
//                           future: getCarousel1(),
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               if (snapshot.data == null) {
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 24.0),
//                                   child: AspectRatio(
//                                       aspectRatio: 20 / 14,
//                                       child: ContentPlaceHolder(
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.4,
//                                       )),
//                                 );
//                               } else {
//                                 var list = snapshot.data as List;
//                                 return CarouselSlider.builder(
//                                   itemCount: list.length,
//                                   itemBuilder: (context, int valve, int nxt) {
//                                     return GestureDetector(
//                                       onTap: () {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (_) =>
//                                                     ChangeNotifierProvider<
//                                                         StateManager>(
//                                                       create: (_) =>
//                                                           StateManager(),
//                                                       child: Details(
//                                                           id: list[valve]
//                                                               ["id"]),
//                                                     )));
//                                       },
//                                       child: Container(
//                                         margin: const EdgeInsets.symmetric(
//                                             horizontal: 0),
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 0.4,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                             image: DecorationImage(
//                                                 colorFilter: ColorFilter.mode(
//                                                     Colors.black
//                                                         .withOpacity(0.35),
//                                                     BlendMode.darken),
//                                                 image: CachedNetworkImageProvider(
//                                                     "https://image.tmdb.org/t/p/w500/ ${list[valve]["poster_path"]}"),
//                                                 fit: BoxFit.cover)),
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 10.0),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.end,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 list[valve]["title"],
//                                                 style: TextStyle(
//                                                     color: Colors.white
//                                                         .withOpacity(0.85),
//                                                     fontWeight: FontWeight.w700,
//                                                     fontSize: 24),
//                                               ),
//                                               Star(
//                                                   starts: list[valve]
//                                                       ["vote_average"]),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   options: CarouselOptions(
//                                       viewportFraction: 0.92,
//                                       autoPlay: true,
//                                       enlargeCenterPage: true,
//                                       aspectRatio: 20 / 14,
//                                       autoPlayCurve: Curves.ease),
//                                 );
//                               }
//                             } else {
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 24.0),
//                                 child: AspectRatio(
//                                     aspectRatio: 20 / 14,
//                                     child: ContentPlaceHolder(
//                                       width: MediaQuery.of(context).size.width,
//                                       height:
//                                           MediaQuery.of(context).size.height *
//                                               0.4,
//                                     )),
//                               );
//                             }
//                           }),

// Consumer<StateManager>(builder: (context, list, child) {
//                         if (list.carousel.isEmpty) {
//                           return Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 24.0),
//                             child: AspectRatio(
//                                 aspectRatio: 20 / 14,
//                                 child: ContentPlaceHolder(
//                                   width: MediaQuery.of(context).size.width,
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.4,
//                                 )),
//                           );
//                         } else {
//                           return CarouselSlider.builder(
//                             itemCount: list.carousel.length,
//                             itemBuilder: (context, int valve, int nxt) {
//                               return GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (_) =>
//                                               ChangeNotifierProvider<
//                                                   StateManager>(
//                                                 create: (_) => StateManager(),
//                                                 child: Details(
//                                                     id: list.carousel[valve]
//                                                         ["id"]),
//                                               )));
//                                 },
//                                 child: Container(
//                                   margin:
//                                       const EdgeInsets.symmetric(horizontal: 0),
//                                   width: MediaQuery.of(context).size.width,
//                                   height:
//                                       MediaQuery.of(context).size.height * 0.4,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12),
//                                       image: DecorationImage(
//                                           colorFilter: ColorFilter.mode(
//                                               Colors.black.withOpacity(0.35),
//                                               BlendMode.darken),
//                                           image: CachedNetworkImageProvider(
//                                               "https://image.tmdb.org/t/p/w500/${list.carousel[valve]["poster_path"]}"),
//                                           fit: BoxFit.cover)),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 10.0),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           list.carousel[valve]["title"],
//                                           style: TextStyle(
//                                               color: Colors.white
//                                                   .withOpacity(0.85),
//                                               fontWeight: FontWeight.w700,
//                                               fontSize: 24),
//                                         ),
//                                         Star(
//                                             starts: list.carousel[valve]
//                                                 ["vote_average"]),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                             options: CarouselOptions(
//                                 viewportFraction: 0.92,
//                                 autoPlay: true,
//                                 enlargeCenterPage: true,
//                                 aspectRatio: 20 / 14,
//                                 autoPlayCurve: Curves.ease),
//                           );
//                         }
//                       }),
//                       const SizedBox(
//                         height: 40,
//                       ),
//                       Column(children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: const [
//                               Text(
//                                 "Trending",
//                                 style: TextStyle(
//                                     fontSize: 32,
//                                     fontWeight: FontWeight.w600,
//                                     color: Colors.white),
//                               ),
//                               Text("See all",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w600))
//                             ],
//                           ),
//                         ),
//                         Consumer<StateManager>(
//                             builder: (context, value, child) {
//                           return SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: value.treading.isEmpty
//                                   ? Row(
//                                       children: List.generate(
//                                           5, (index) => const MovieCardPlace()))
//                                   : Row(
//                                       children: List.generate(
//                                       value.treading.length,
//                                       (index) => GestureDetector(
//                                         child: MovieCard(
//                                           poster: value.treading[index]
//                                                   ["poster_path"] ??
//                                               "https://www.bastiaanmulder.nl/wp-content/uploads/2013/11/dummy-image-square.jpg",
//                                           title: value.treading[index]["title"],
//                                           rate: value.treading[index]
//                                               ["vote_average"],
//                                         ),
//                                         onTap: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (_) =>
//                                                       ChangeNotifierProvider<
//                                                           StateManager>(
//                                                         create: (_) =>
//                                                             StateManager(),
//                                                         child: Details(
//                                                           id: value.treading[
//                                                               index]["id"],
//                                                         ),
//                                                       )));
//                                         },
//                                       ),
//                                     )));
//                         })
//                       ]),
