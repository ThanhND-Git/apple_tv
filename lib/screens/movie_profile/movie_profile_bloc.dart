import 'dart:async';

import 'package:apple_tv/base/bloc.dart';

import '../../models/movie.dart';
import '../../shared_preferences/shared_preferences.dart';

class MovieProfilePageBloc extends Bloc {
  Movie movie;

  MovieProfilePageBloc({required this.movie});

  final _isLikedStreamController = StreamController<bool>.broadcast();

  Stream<bool> get isLikedStream => _isLikedStreamController.stream;

  StreamSink get _isLikedStreamSink => _isLikedStreamController.sink;

  //create list More Movies has yearOfManufacture +-2
  Set<Movie> createListMoreMovies(Movie movie) {
    return Bloc()
        .listMovies
        .where((element) =>
            movie.name != element.name &&
            movie.yearOfManufacture - 2 <= element.yearOfManufacture &&
            element.yearOfManufacture <= movie.yearOfManufacture + 2)
        .toSet();
  }

  //init Favorite Movie List and compare received movie with movies in favorite list to set Icon Like in Movie Profile Page
  Future<void> compareMovie() async {
    Set<Movie> listMovies = await MySharedPreferences.getListFavoriteMovies();
    if (listMovies.contains(movie)) {
      movie.isLiked = true;
    } else {
      movie.isLiked = false;
    }
  }

  //set isLiked for movie
  Future<void> setIsLiked() async {
    movie.isLiked = !movie.isLiked;
    _isLikedStreamSink.add(movie.isLiked);
  }

  //handle movie if liked or not
  Future<void> handleMovie(Movie movie) async {
    if (movie.isLiked) {
      await addMovieToListFavorite(movie);
    } else {
      await removeMovieToListFavorite(movie);
    }
  }

  Future<void> addMovieToListFavorite(Movie movie) async {
    //get listMovies from MySharedPreferences
    Set<Movie> listMovies = await MySharedPreferences.getListFavoriteMovies();
    //add movie to list
    listMovies.add(movie);
    MySharedPreferences.saveListFavoriteMovies(listMovies);
  }

  Future<void> removeMovieToListFavorite(Movie movie) async {
    //get listMovies from MySharedPreferences
    Set<Movie> listMovies = await MySharedPreferences.getListFavoriteMovies();
    //remove movie to list
    listMovies.remove(movie);
    MySharedPreferences.saveListFavoriteMovies(listMovies);
  }
}
