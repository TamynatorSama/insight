import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:insight1/models/detail_model.dart';
import 'package:insight1/models/quiz_model.dart';
import 'package:insight1/models/search_model.dart';
import 'package:insight1/models/sereis_details_model.dart';
import 'package:insight1/models/series.dart';
import 'package:insight1/models/series_episodes.dart';
import 'package:insight1/models/tailermodel.dart';
import 'package:insight1/models/videomodel.dart';
import "package:insight1/logic/keys.dart";

class HttpReq {
  HttpReq._();
  static final HttpReq request = HttpReq._();
  // this function is to get the list for images in the slide show
  Future<List> getCarousel() async {
    var url = Uri.parse(
        "$apiEndPoint/movie/now_playing?api_key=$apiKey&language=en-US&page=1");
    try {
      var response = await http.get(url);
      var result = jsonDecode(response.body);
      var parsable = result["results"] as List;
      return parsable;
    } on SocketException {
      throw "exception";
    }
  }

// the thre  next functions are to get the video and details of the movie
  Future<List<TrailerModel>> videoDetail(int id) async {
    var url = Uri.parse(
        "$apiEndPoint/movie/$id/videos?api_key=$apiKey&language=en-US");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      var imdbId = result["results"] as List;
      var trailerList =
          imdbId.map<TrailerModel>((e) => TrailerModel.fromJson(e)).toList();
      return trailerList;
    } else {
      throw "error";
    }
  }

// tamyantor = k_d017257x
//colesage = k_q80noplr =used
// akinyemi = k_5z14diqt =using
  Future<VideoModel> getVideoLink(String videoId) async {
    var url = Uri.parse("https://imdb-api.com/API/YouTube/k_5z14diqt/$videoId");
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    var list = VideoModel.fromJson(result);
    return list;
  }

  //function to get list that will be in treanding

  Future<List> getTreanding() async {
    var url = Uri.parse(
        "$apiEndPoint/movie/popular?api_key=$apiKey&language=en-US&page=1");
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    var trends = result["results"];
    return trends;
  }

  //series api call
  Future<List<SeriesModel>> seriesPopular() async {
    var url = Uri.parse(
        "$apiEndPoint/tv/popular?api_key=$apiKey&language=en-US&page=1");
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    var popularseries = result["results"] as List;
    var parsed =
        popularseries.map<SeriesModel>((e) => SeriesModel.fromJson(e)).toList();
    // print(parsed);
    return parsed;
  }

  Future<List<SeriesModel>> playingSeries() async {
    var url = Uri.parse(
        "$apiEndPoint/tv/airing_today?api_key=$apiKey&language=en-US&page=1");
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    var playingSeries = result["results"] as List;
    var parsed =
        playingSeries.map<SeriesModel>((e) => SeriesModel.fromJson(e)).toList();
    return parsed;
  }

  Future<SeriesDetailsModel> getSeriesDetails(int id) async {
    var url = Uri.parse(
        "$apiEndPoint/tv/$id?api_key=$apiKey&language=en-US");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var parsed = SeriesDetailsModel.fromJson(result);
        return parsed;
      } else {
        throw "api error";
      }
    } catch (e) {
      rethrow;
    }
  }

  //search api call

  Future<List<SearchModel>> search(String query) async {
    var url = Uri.parse(
        "$apiEndPoint/search/multi?api_key=$apiKey&language=en-US&query=$query&page=1&include_adult=true");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      var search = result["results"] as List;
      var list =
          search.map<SearchModel>((e) => SearchModel.fromJson(e)).toList();
      return list;
    } else {
      throw "The api is under construction";
    }
  }

  //details api call

  Future<DetailsModel> getdetails(int id) async {
    var url =
        "$apiEndPoint/movie/$id?api_key=$apiKey&language=en-US";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var details = DetailsModel.fromJson(result);
        return details;
      } else {
        throw "error";
      }
    } on TimeoutException {
      throw "e";
    }
  }

  //quiz api call
  Future<List<QuizModel>> getquiz() async {
    var url =
        "https://the-trivia-api.com/api/questions?categories=film_and_tv&limit=20&difficulty=easy";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = json.decode(response.body);
        var list = result.map<QuizModel>((x) => QuizModel.fromJson(x)).toList();
        return list;
      } else {
        throw "erroe";
      }
    } catch (e) {
      throw "erroe";
    }
  }

  //getting the list of series episode each season per click
  Future<List<SeriesEpisodeModel>> getEpisodes(int id, int seasonNum) async {
    var url =
        "$apiEndPoint/tv/$id/season/$seasonNum?api_key=$apiKey&language=en-US";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var owk = result["episodes"] as List;
        var list = owk
            .map<SeriesEpisodeModel>((e) => SeriesEpisodeModel.fromJson(e))
            .toList();
        return list;
      } else {
        throw 'error';
      }
    } catch (e) {
      throw "$e";
    }
  }
}
