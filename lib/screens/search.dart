import 'package:flutter/material.dart';
import 'package:insight1/logic/settings_handler.dart';
import 'package:insight1/logic/state.dart';
import 'package:insight1/reusable/button.dart';
import 'package:insight1/reusable/recent.dart';
// import 'package:insight1/reusable/search_placeholeder.dart';
import 'package:insight1/reusable/searchcard.dart';
import 'package:insight1/screens/details.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  SharedPreferences? searchPrefrence;

  @override
  void initState() {
    getSearches();
    super.initState();
  }

  getSearches() async {
    searchPrefrence = await SharedPreferences.getInstance();
    var list = searchPrefrence!.getStringList('search');
    // ignore: use_build_context_synchronously
    Provider.of<StateManager>(context, listen: false).setSeachList(list);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future start() async {
    searchPrefrence = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    Provider.of<StateManager>(context, listen: false)
        .saveSearches(searchPrefrence!);
  }

  @override
  Widget build(BuildContext context) {
    List searchHistory = Provider.of<StateManager>(context).searchHistory;

    return Scaffold(
      backgroundColor: const Color(0xff303030),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10, 20.0, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      // Search(),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          decoration: const InputDecoration(
                              hintText: "search",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none),
                          onSubmitted: (data) {
                            if (data == "") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Enter a text in the searchbar",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 10,
                                          offset: const Offset(2, 4))
                                    ]),
                              )));
                            } else {
                              Provider.of<StateManager>(context, listen: false)
                                  .test(data);
                              start();
                              Provider.of<StateManager>(context, listen: false)
                                  .getSearch(data.replaceAll(" ", "%20"));
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: GestureDetector(
                          onTap: () {
                            if (_controller.text == "") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Enter a text in the searchbar",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black.withOpacity(0.5),
                                          blurRadius: 10,
                                          offset: const Offset(2, 4))
                                    ]),
                              )));
                            } else {
                              Provider.of<StateManager>(context, listen: false)
                                  .test(_controller.text);
                              start();
                              Provider.of<StateManager>(context, listen: false)
                                  .getSearch(
                                      _controller.text.replaceAll(" ", "%20"));
                            }
                          },
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                StreamBuilder(
                    stream: Provider.of<StateManager>(context).search.stream,
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Recent",
                                    style: TextStyle(
                                        fontSize: 28,
                                        color: Colors.white.withOpacity(0.8),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 24, 24, 24),
                                                  child: Container(
                                                    color: const Color.fromARGB(
                                                        255, 24, 24, 24),
                                                    height: 200,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        const Text(
                                                            "Delete Recent Searched ?",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            InkWell(
                                                              child: Clickable(
                                                                back: SettingsHandler()
                                                                    .accentColor,
                                                                text: 'Cancel',
                                                                textColor:
                                                                    const Color
                                                                            .fromARGB(
                                                                        255,
                                                                        59,
                                                                        59,
                                                                        59),
                                                              ),
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context,
                                                                    true);
                                                              },
                                                            ),
                                                            InkWell(
                                                              child: const Clickable(
                                                                  back: Colors
                                                                      .red,
                                                                  text:
                                                                      'Delete',
                                                                  textColor:
                                                                      Colors
                                                                          .white),
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context,
                                                                    true);
                                                                Provider.of<StateManager>(
                                                                        context)
                                                                    .reset();
                                                              },
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      },
                                      icon: const Icon(
                                        Icons.cancel,
                                        color: Colors.white,
                                        size: 16,
                                      ))
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  searchHistory.length,
                                  (index) => Recent(
                                        text: searchHistory[index],
                                        hello: () {
                                          // Navigator.of(context).push(route)
                                        },
                                      )),
                            )
                          ],
                        );
                      } else {
                        if (snapshot.hasData) {
                          var searchList = snapshot.data as List;
                          if (searchList.isEmpty) {
                            return const Center(
                              child: Text(
                                "No Results found",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            );
                          } else {
                            return Column(
                              children: List.generate(
                                  searchList.length,
                                  (index) => GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => Details(
                                                      id: int.parse(
                                                          (searchList[index]
                                                                  .imdbid)
                                                              .toString()
                                                              .replaceAll(
                                                                  "tt", "")))));
                                        },
                                        child: SearchResult(
                                            image: searchList[index].image,
                                            title: searchList[index].title,
                                            description:
                                                searchList[index].type),
                                      )),
                            );
                          }
                        } else {
                          return const Center(
                            child: Text(
                              "No Results found",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          );
                        }
                      }
                    }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
