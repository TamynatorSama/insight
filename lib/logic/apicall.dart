import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:insight1/models/detail_model.dart';
import 'package:insight1/models/quiz_model.dart';
import 'package:insight1/models/search_model.dart';
import 'package:insight1/models/sereis_details_model.dart';
import 'package:insight1/models/series.dart';
import 'package:insight1/models/tailermodel.dart';
import 'package:insight1/models/videomodel.dart';

class HttpReq {
  HttpReq._();
  static final HttpReq request = HttpReq._();
  // this function is to get the list for images in the slide show
  Future<List> getCarousel() async {
    var url = Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=5d0cb31abcfc25b0cea56eeee270e412&language=en-US&page=1");
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
        "https://api.themoviedb.org/3/movie/$id/videos?api_key=5d0cb31abcfc25b0cea56eeee270e412&language=en-US");
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
//colesage = k_q80noplr =using
// akinyemi = k_5z14diqt = used
  Future<VideoModel> getVideoLink(String videoId) async {
    var url = Uri.parse("https://imdb-api.com/API/YouTube/k_q80noplr/$videoId");
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    var list = VideoModel.fromJson(result);
    return list;
  }

  //function to get list that will be in treanding

  Future<List> getTreanding() async {
    var url = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=5d0cb31abcfc25b0cea56eeee270e412&language=en-US&page=1");
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    var trends = result["results"];
    return trends;
  }

  // upcoming api call
  Future<List> getUpcoming() async {
    var url = Uri.parse(
        "https://api.themoviedb.org/3/movie/upcoming?api_key=5d0cb31abcfc25b0cea56eeee270e412&language=en-US&page=1");
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    var upcoming = result["results"];
    return upcoming;
  }

  //series api call
  Future<List<SeriesModel>> seriesPopular() async {
    var url = Uri.parse(
        "https://api.themoviedb.org/3/tv/popular?api_key=5d0cb31abcfc25b0cea56eeee270e412&language=en-US&page=1");
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
        "https://api.themoviedb.org/3/tv/airing_today?api_key=5d0cb31abcfc25b0cea56eeee270e412&language=en-US&page=1");
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    var playingSeries = result["results"] as List;
    var parsed =
        playingSeries.map<SeriesModel>((e) => SeriesModel.fromJson(e)).toList();
    return parsed;
  }

  Future<SeriesDetailsModel> getSeriesDetails(int id) async {
    var url = Uri.parse(
        "https://api.themoviedb.org/3/tv/$id?api_key=5d0cb31abcfc25b0cea56eeee270e412&language=en-US");
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

  Future<List<SeriesModel>> getSeriesRecomended(int id) async {
    var url = Uri.parse(
        "https://api.themoviedb.org/3/tv/$id/similar?api_key=5d0cb31abcfc25b0cea56eeee270e412&language=en-US&page=1");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var parsable = result["results"] as List;
        var parsed = parsable.map<SeriesModel>((e) => SeriesModel.fromJson(e)).toList();
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
        "http://thubbackend.herokuapp.com/search/?searchparams=$query");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      var search = result as List;
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
        "https://api.themoviedb.org/3/movie/$id?api_key=5d0cb31abcfc25b0cea56eeee270e412&language=en-US";
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
}
