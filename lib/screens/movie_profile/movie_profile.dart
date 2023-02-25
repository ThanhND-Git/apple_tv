import 'package:apple_tv/custom_widget/custom_image_cliprrect.dart';
import 'package:apple_tv/models/movie.dart';
import 'package:flutter/material.dart';

import 'movie_profile_bloc.dart';

class MovieProfilePage extends StatefulWidget {
  final Movie movie;

  const MovieProfilePage({super.key, required this.movie});

  @override
  State<MovieProfilePage> createState() => _MovieProfilePageState();
}

class _MovieProfilePageState extends State<MovieProfilePage> {
  late final Movie movie;
  late final MovieProfilePageBloc _movieProfilePageBloc;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    movie = widget.movie;
    _movieProfilePageBloc = MovieProfilePageBloc(movie: movie);
  }

  @override
  void dispose() {
    _movieProfilePageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade700,
      body: Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 500,
          child: Image.asset(
            movie.urlPhoto,
            fit: BoxFit.fill,
          ),
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                height: 350,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.shade700,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                      child: Text(
                                    'IMDb',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                  )),
                                ),
                                // số điểm IMDb
                                Text(
                                  ' ${movie.iMDb}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                      child: Text(
                                    'PC-16',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey.shade300),
                                  )),
                                ),
                              ],
                            ),
                            //tên phim
                            Text(
                              movie.name,
                              style: const TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            //năm sản xuất
                            Text(
                              '${movie.yearOfManufacture} / ${movie.time}',
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey.shade300),
                            ),
                            // thể loại
                            Text(
                              movie.categories != null
                                  ? movie.categories!.join(', ')
                                  : '',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey.shade500),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'More Movies',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 136,
                            ),
                          ],
                        ),
                      ),

                      //button "Watch now"
                      buildButtonWatchNow(context)
                    ]),
              ),
            ),

            //list "More Movie"
            buildListMoreMovies(),

            //"Like" button
            buildLikeButton(),
          ],
        )
      ]),
    );
  }

  InkWell buildButtonWatchNow(BuildContext context) {
    return InkWell(
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Center(child: Text('Phim đang được cập nhật. Xin vui lòng vào lại sau!')),
      )),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        child: Container(
          height: 54,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xffee0342),
              Color(0xffec0d49),
              Color(0xFFE0258E),
              Color(0xFFE337A8)
            ],
          )),
          child: const Center(
              child: Text(
            'Watch now',
            style: TextStyle(color: Color(0xFFCBCBCB), fontSize: 20),
          )),
        ),
      ),
    );
  }

  Positioned buildListMoreMovies() {
    return Positioned(
      left: 30,
      bottom: 70,
      child: Builder(builder: (context) {
        final listMovieFeatured =
            _movieProfilePageBloc.createListMoreMovies(movie);
        return SizedBox(
          height: 110,
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: listMovieFeatured.length,
            itemBuilder: (context, index) {
              final movie = listMovieFeatured.elementAt(index);
              final urlPhoto = movie.urlPhoto;
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MovieProfilePage(movie: movie),
                )),
                child: MyImageInClipRRect(width: 85, urlPhoto: urlPhoto),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                width: 10,
              );
            },
          ),
        );
      }),
    );
  }

  FutureBuilder<void> buildLikeButton() {
    //before build Icon Button Like, i want compare received movie with movies in favorite list to set Icon Like
    return FutureBuilder(
      future: _movieProfilePageBloc.compareMovie(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Text('An error has occurred');
          }
          return Positioned(
            right: 20,
            top: 50,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.white),
              child: StreamBuilder<bool>(
                  stream: _movieProfilePageBloc.isLikedStream,
                  builder: (context, snapshot) {
                    final isLiked = snapshot.data ?? movie.isLiked;
                    return IconButton(
                        onPressed: () async {
                          // set isLiked of Movie == true
                          await _movieProfilePageBloc.setIsLiked();
                          //add or remove movie to List Favorite Movie
                          await _movieProfilePageBloc.handleMovie(movie);
                        },
                        icon: Icon(
                          Icons.thumb_up,
                          color: isLiked == false
                              ? Colors.grey
                              : IconTheme.of(context).color,
                        ));
                  }),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
