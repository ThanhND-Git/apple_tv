import '../../base/bloc.dart';
import '../../models/movie.dart';
import '../../shared_preferences/shared_preferences.dart';

class FavoritePageBloc extends Bloc {
  //get ListFavorite from
  Future<Set<Movie>> getListMovieFavorite() async {
    return await MySharedPreferences.getListFavoriteMovies();
  }

  @override
  // ignore: unnecessary_overrides
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
  }
}
