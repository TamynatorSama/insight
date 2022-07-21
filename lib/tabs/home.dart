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
    Provider.of<StateManager>(context, listen: false).populatePopularSeries();
    Provider.of<StateManager>(context, listen: false).populatePlayingSeries();
    super.initState();
  }

  bool openSearch = true;
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List category = ["Movies", "Series", "Watchlist"];

    final List screens = [
      const MoviesScreen(),
      const SeriesScreen(),
      const WatchlistScreen()
    ];

    int selectCat = Provider.of<StateManager>(context).selectCat;
    var themeMode = Provider.of<SettingsHandler>(context).mode;

    return Padding(
        padding: const EdgeInsets.only(top: 8.0), //use 8.0 for padding
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Column(
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Offstage(
                      offstage: false,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (Provider.of<ConnectivityA>(context,
                                        listen: false)
                                    .isConnected ==
                                false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "You are not connected to the internet")));
                            } else {
                              openSearch = !openSearch;
                            }
                          });
                        },
                        child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                left: 24, bottom: 15, top: 15),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 88, 88, 88),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                                openSearch == true ? Icons.search : Icons.close,
                                color: Colors.white)),
                      ),
                    ),
                    Expanded(
                      child: Offstage(
                        offstage: openSearch,
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 15),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 108, 108, 108),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 2),
                                    child: TextField(
                                        controller: _textController,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        )),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      if (_textController.value.text.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Enter a text in the search bar")));
                                      } else {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    MultiProvider(
                                                      providers: [
                                                        ChangeNotifierProvider<
                                                            StateManager>(
                                                          create: ((context) =>
                                                              StateManager()),
                                                          child: Search(
                                                              theme: themeMode,
                                                              query:
                                                                  _textController
                                                                      .text),
                                                        ),
                                                        ChangeNotifierProvider<
                                                            SettingsHandler>(
                                                          create: ((context) =>
                                                              SettingsHandler()),
                                                          child: Search(
                                                              theme: themeMode,
                                                              query:
                                                                  _textController
                                                                      .text),
                                                        ),
                                                      ],
                                                      child: Search(
                                                          theme: themeMode,
                                                          query: _textController
                                                              .text),
                                                    ))));
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ))
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Category",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: themeMode.fontFamilyUse == "stalinist" ? 24:32,
                        fontFamily: themeMode.fontFamilyUse,
                        fontWeight: FontWeight.w600,
                        color: themeMode.fontColor),
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
                                  color: themeMode.accentColor,
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
                                ? TextStyle(
                                  fontFamily: themeMode.fontFamilyUse,
                                    fontSize: themeMode.fontFamilyUse == "stalinist" ? 12:16, fontWeight: FontWeight.bold, color: Colors.black)
                                :  TextStyle(
                                    color: themeMode.fontColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )),
              Expanded(
                  child: PageView.builder(
                      onPageChanged: (value) {
                        Provider.of<StateManager>(context, listen: false)
                            .changeCat(value);
                      },
                      itemCount: screens.length,
                      itemBuilder: ((context, index) {
                        return screens[
                            Provider.of<StateManager>(context).selectCat];
                      }))),
            ],
          ),
          Consumer<ConnectivityA>(builder: (context, modal, child) {
            if (modal.isConnected) {
              return const Offstage(
                offstage: true,
              );
            } else {
              return Icon(Icons.wifi_off,
                  color: themeMode.accentColor,
                  size: 70);
            }
          }),
        ]));
  }
}
