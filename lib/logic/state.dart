import 'dart:async';

import 'package:flutter/material.dart';
import 'package:insight1/logic/apicall.dart';
import 'package:insight1/models/search_model.dart';
import 'package:insight1/models/sereis_details_model.dart';
import 'package:insight1/models/series.dart';
import 'package:insight1/models/series_episodes.dart';
import 'package:insight1/reusable/video_player.dart';
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

  //movie data instances
  List carousel = [];
  List treading = [];
  List<SeriesModel> popularSeries = [];
  List<SeriesModel> playingSeries = [];
  List<SeriesEpisodeModel> seriesEpisode = [];
  List<List<SearchModel>> search = [];
  SeriesDetailsModel model = SeriesDetailsModel(
      releasedate: "",
      runtime: "",
      rating: "7",
      posterPath: "",
      overview: "",
      genres: [Genres(name: "name")],
      title: "",
      numberSeasons: 1);
  // SeriesEpisodeDetailsModel seriesEpisodeEach = SeriesEpisodeDetailsModel(
  //     airDate: "",
  //     episodeNum: 1,
  //     name: "",
  //     overview: "",
  //     runtime: "",
  //     stillPath: "",
  //     voteAverage: "",
  //     stars: []
  //     );
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

  //getting search results
  // getSearchResult(int id){
  //   sear
  // }
  // getting series details
  getSeriesDetais(int id) async {
    model = await HttpReq.request.getSeriesDetails(id);
    notifyListeners();
  }

  // getting episodes

  getEpisodes(int id, int seasonNum) async {
    seriesEpisode = await HttpReq.request.getEpisodes(id, seasonNum);
    notifyListeners();
  }
  //getting details for each episode of a series season
  // getEpisodeDetails(int id, int season, int epi) async {
  //   seriesEpisodeEach = await HttpReq.request.getSeriesEpisode(id, season, epi);
  //   notifyListeners();
  // }

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

  //function for updating and kepping the state of the search history

  //search api call
  getSearch(String text) async {
    var result = await HttpReq.request.search(text);
    search.add(result);
    notifyListeners();
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
