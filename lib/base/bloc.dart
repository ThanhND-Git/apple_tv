import 'package:apple_tv/models/channel.dart';
import 'package:apple_tv/models/movie.dart';
import 'package:apple_tv/shared/data/data_channels.dart';

import '../shared/data/data_movies.dart';

class Bloc{

  //data movie
  final Set<Movie> listMovies = DataMovies().listMovies;
  //data channel
  final Set<Channel> listChannels = DataChannels().listChanels;

  void dispose() {}
}