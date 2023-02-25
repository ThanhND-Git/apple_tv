import 'dart:convert';

import 'package:apple_tv/models/channel.dart';
import 'package:apple_tv/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{
  static late SharedPreferences _sharedPreferences;

  static Future<void> initSharedPreferences() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String movieListToJson(Set<Movie> movieList) => json.encode(List<dynamic>.from(movieList.map((x) => x.toJson())));
  static Set<Movie> movieListFromJson(String str) => Set<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));
  
  static Future<void> saveListFavoriteMovies(Set<Movie> movieList) async {
    _sharedPreferences.setString('movieList', movieListToJson(movieList));
  }
  static Future<Set<Movie>> getListFavoriteMovies() async {
    final movieListJson = _sharedPreferences.getString('movieList');
    return movieListFromJson(movieListJson ?? '[]');
  }

  static String channelListToJson(Set<Channel> channelList) => json.encode(List<dynamic>.from(channelList.map((x) => x.toJson())));
  static Set<Channel> channelListFromJson(String str) => Set<Channel>.from(json.decode(str).map((x) => Channel.fromJson(x)));

  static Future<void> saveListFavoriteChannel(Set<Channel> channelList) async {
    _sharedPreferences.setString('channelList', channelListToJson(channelList));
  }
  static Future<Set<Channel>> getListFavoriteChannels() async {
    final channelListJson = _sharedPreferences.getString('channelList');
    return channelListFromJson(channelListJson ?? '[]');
  }

}