import 'package:flutter/material.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:insight1/logic/state.dart';
import 'package:insight1/models/setting_model.dart';
import 'package:insight1/reusable/searchcard.dart';
import 'package:insight1/reusable/text_placeholder.dart';
import 'package:insight1/screens/details.dart';
import 'package:insight1/screens/series_details.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  final String query;
  final SettingsModel theme;
  const Search(
      {Key? key,
      required this.query,
      required this.theme})
      : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ScrollController scroll = ScrollController(keepScrollOffset: true);

  @override
  void didChangeDependencies() {
    Provider.of<StateManager>(context)
        .getSearch(widget.query.replaceAll(" ", "%20"));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.theme.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                        color: widget.theme.fontColor,
                      ),
                    ),
                    Text(
                      "Search result",
                      style: TextStyle(
                          color: widget.theme.fontColor,
                          fontSize: MediaQuery.of(context).size.width * 0.07),
                    ),
                  ],
                ),
                Expanded(
                    child: SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height,
                  child:
                      Consumer<StateManager>(builder: (context, value, index) {
                    if (value.search.isEmpty) {
                      return Center(
                        child: TextPlace(
                          color: widget.theme.fontColor,
                            text: "Getting Search for ${widget.query}"),
                      );
                    } else {
                      return SingleChildScrollView(
                        controller: scroll,
                        child: Column(
                          children:
                              List.generate(value.search[0].length, (index) {
                            if (value.search[0][index].image == "null" ||
                                value.search[0][index].title == "null") {
                              return const Offstage();
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: ((context) {
                                    return MultiProvider(
                                        providers: [
                                          ChangeNotifierProvider<StateManager>(
                                              create: (_) => StateManager(),
                                              child: value.search[0][index]
                                                          .type ==
                                                      "tv"
                                                  ? SeriesDetails(
                                                    fontColor: widget.theme.fontColor,
                                                      background:
                                                          widget.theme.background,
                                                      color: widget.theme.accentColor,
                                                      pics: value
                                                          .search[0][index]
                                                          .image,
                                                      id: value
                                                          .search[0][index].id)
                                                  : Details(
                                                    fontColor: widget.theme.fontColor,
                                                      background:
                                                          widget.theme.background,
                                                      color: widget.theme.accentColor,
                                                      id: value.search[0][index]
                                                          .id)),
                                          ChangeNotifierProvider<
                                                  SettingsHandler>(
                                              create: (_) => SettingsHandler(),
                                              child: value.search[0][index]
                                                          .type ==
                                                      "tv"
                                                  ? SeriesDetails(
                                                    fontColor: widget.theme.fontColor,
                                                      background:
                                                          widget.theme.background,
                                                      color: widget.theme.accentColor,
                                                      pics: value
                                                          .search[0][index]
                                                          .image,
                                                      id: value
                                                          .search[0][index].id)
                                                  : Details(
                                                    fontColor: widget.theme.fontColor,
                                                      background:
                                                          widget.theme.background,
                                                      color: widget.theme.accentColor,
                                                      id: value
                                                          .search[0][index].id))
                                        ],
                                        child: value.search[0][index].type ==
                                                "tv"
                                            ? SeriesDetails(
                                              fontColor: widget.theme.fontColor,
                                                background:
                                                          widget.theme.background,
                                                      color: widget.theme.accentColor,
                                                pics: value
                                                    .search[0][index].image,
                                                id: value.search[0][index].id)
                                            : Details(
                                              fontColor: widget.theme.fontColor,
                                                background:
                                                          widget.theme.background,
                                                      color: widget.theme.accentColor,
                                                id: value.search[0][index].id));
                                  })));
                                },
                                child: SearchResult(
                                  font: widget.theme.fontColor,
                                    image:
                                        "https://image.tmdb.org/t/p/w500/${value.search[0][index].image}",
                                    title: value.search[0][index].title,
                                    description: value.search[0][index].type),
                              );
                            }
                          }),
                        ),
                      );
                    }
                  }),
                ))
              ],
            ),
          ),
        ));
  }
}
