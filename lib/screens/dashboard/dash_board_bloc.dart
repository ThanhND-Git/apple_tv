// ignore_for_file: unnecessary_getters_setters

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:apple_tv/base/bloc.dart';

import '../../models/movie.dart';

class DashBoardBloc extends Bloc {
  //tạo danh sách Movies

  // Featured 
  final Set<Movie> _listMovieFeatured =
      Bloc().listMovies.where((element) => element.iMDb >= 8).toSet();
  // New realese
  final Set<Movie> _listMovieNewRealese = Bloc()
      .listMovies
      .where((element) => element.yearOfManufacture >= 2020)
      .toSet();
  // Series
  final Set<Movie> _listMovieSeries = Bloc()
      .listMovies
      .where((element) => element.name.contains('Spider-Man'))
      .toSet();
  
  //getter
  Set<Movie> get listMovieNewRealese => _listMovieNewRealese;
  Set<Movie> get listMovieSeries => _listMovieSeries;
  Set<Movie> get listMovieFeatured => _listMovieFeatured;
  
  //create listMovieWhatToWatch with 5 random movies from all movie
  Set<Movie> getRandomListMovieWhatToWatch() {
    final random = Random();
    Set<Movie> listMovieWhatToWatch = {};
    for (int i = 0; i < 5; i++) {
      int randomIndex = random.nextInt(Bloc().listMovies.length);
      listMovieWhatToWatch.add(Bloc().listMovies.elementAt(randomIndex));
    }
    return listMovieWhatToWatch;
  }

  late TabController _tabController;
  //init Page Controller
  final _dashBoardController = PageController();

  // _currentPage = 0;

  @override
  void dispose() {
    _tabController.dispose();
    _dashBoardController.dispose();
    super.dispose();
  }

  // get currentPage => _currentPage;
  get dashBoardController => _dashBoardController;

  TabController get tabController => _tabController;

  set tabController(TabController value) {
    _tabController = value;
  }
}
