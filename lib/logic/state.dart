import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insight1/logic/apicall.dart';
import 'package:insight1/models/search_model.dart';
import 'package:insight1/models/sereis_details_model.dart';
import 'package:insight1/models/series.dart';
import 'package:insight1/reusable/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class StateManager extends ChangeNotifier {
  int selectedindex = 0;
  int selectCat = 0;
  bool play = false;
  List<String> searchHistory = [];
  String positionState = "00:00";
  bool setLandscape = false;
  int score = 0;

  //function for animated video player

  final search = StreamController<List<SearchModel>>();

  //movie data instances
  List carousel = [];
  List treading = [];
  List<SeriesModel> popularSeries = [];
  List<SeriesModel> playingSeries = [];
  List<SeriesModel> recomemdedSeries = [];
  SeriesDetailsModel model = SeriesDetailsModel(
      releasedate: "",
      runtime: "",
      rating: "7",
      posterPath: "",
      overview: "",
      genres: [Genres(name: "name")],
      title: "",
      numberSeasons: 1);
  populateCarousel() async {
    carousel = await HttpReq.request.getCarousel();
    notifyListeners();
  }

  populateTreanding() async {
    treading = await HttpReq.request.getTreanding();
    notifyListeners();
  }

  populatePopularSeries() async {
    popularSeries = await HttpReq.request.seriesPopular();
    notifyListeners();
  }

  populatePlayingSeries() async {
    playingSeries = await HttpReq.request.playingSeries();
    notifyListeners();
  }

  // getting series details
  getSeriesDetais(int id) async {
    model = await HttpReq.request.getSeriesDetails(id);
    notifyListeners();
  }

  // getting recomendedation
  getSeriesRecomendation(int id) async {
    recomemdedSeries = [];
    recomemdedSeries = await HttpReq.request.getSeriesRecomended(id);
    notifyListeners();
  }

  changebool(AnimationController? controller, VideoPlayerController control) {
    play = !play;
    if (play) {
      control.pause();
      controller!.forward();
    } else {
      control.play();
      controller!.reverse();
    }
    // play ? : ;
    notifyListeners();
  }

  changeIndex(int index) {
    selectedindex = index;
    notifyListeners();
  }

  changeCat(int index) {
    selectCat = index;
    notifyListeners();
  }

  // The next two function is to set and retrive the search hsitory for shared prefrence

  //this set the search history on initialize and send the result to the search screen
  setSeachList(var list) {
    if (list == null) {
      searchHistory = [];
    } else {
      searchHistory = list;
    }
    notifyListeners();
  }

  Future saveSearches(SharedPreferences preferences) async {
    await preferences.setStringList('search', searchHistory);
  }

  //function for updating and kepping the state of the search history
  test(String text) {
    if (searchHistory.contains(text) ||
        searchHistory.contains(text.toUpperCase())) {
      return;
    } else {
      searchHistory.add(text);
      if (searchHistory.length > 4) {
        searchHistory.removeRange(0, searchHistory.length - 4);
      }
    }
    notifyListeners();
  }

  //reset search history
  reset() {
    searchHistory = [];
    notifyListeners();
  }

  //search api call
  getSearch(String text) async {
    search.sink.add(await HttpReq.request.search(text));
  }

  //function for getiing postition os seek
  Future<String> getPosition(VideoPlayerController video) async {
    var position = await video.position;
    var formatedpos = convertDuration(position!);
    positionState = formatedpos;
    notifyListeners();
    return formatedpos;
  }

  //bool for setting device orientation

  setOrientation(BuildContext context) {
    //   var orientation = MediaQuery.of(context).orientation;

    // if (orientation == Orientation.portrait){

    // }
    setLandscape = !setLandscape;
    notifyListeners();
  }

  // game state handler
  gamePlay() {
    score += 1;
    notifyListeners();
  }
}
