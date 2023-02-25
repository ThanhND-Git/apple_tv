import 'package:flutter/material.dart';
import '../../custom_widget/custom_image_cliprrect.dart';
import '../../models/movie.dart';
import '../movie_profile/movie_profile.dart';
import 'favorite_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  //init FavoritePageBloc
  final _favoritePageBloc = FavoritePageBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _favoritePageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: _favoritePageBloc.getListMovieFavorite(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Có 1 lỗi đã xảy ra');
                }
                Set<Movie>? listMovie = snapshot.data;
                return listMovie == null || listMovie.isEmpty
                    ? buildTextEmptyListMovie()
                    : buildListViewMovies(listMovie);
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildTextEmptyListMovie() => const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            "Danh sách phim yêu thích của bạn đang trống! Bạn cần Like 1 phim để thêm vào danh sách.",
            style: TextStyle(fontSize: 13, color: Colors.grey),
          ),
        ),
      );

  Widget buildListViewMovies(Set<Movie> listMovie) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: listMovie.length,
      itemBuilder: (context, index) {
        final movie = listMovie.elementAt(index);
        final urlPhoto = movie.urlPhoto;
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MovieProfilePage(movie: movie),
          )),
          child: Stack(
            children: [
              MyImageInClipRRect(width: 400, urlPhoto: urlPhoto),
              Positioned(
                  left: 10,
                  bottom: 10,
                  child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 200,
                        minWidth: 110,
                      ),
                      padding: const EdgeInsets.all(5),
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        movie.name,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ))))
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
