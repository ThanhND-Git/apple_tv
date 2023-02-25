import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../custom_widget/custom_image_cliprrect.dart';
import '../../models/movie.dart';
import '../movie_profile/movie_profile.dart';
import 'dash_board_bloc.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  //init bloc
  final _dashBoardBloc = DashBoardBloc();
  late Set<Movie> listMovieWhatToWatch;
  @override
  void initState() {
    super.initState();
    _dashBoardBloc.tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _dashBoardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    //create listMovieWhatToWatch by random 5 Movie from all movie
    listMovieWhatToWatch = _dashBoardBloc.getRandomListMovieWhatToWatch();
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        // height: height - 150,
        color: Colors.grey.shade800,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //build TabBar and TabView
              SizedBox(
                height: 450,
                child: buildTabBarAndTabViewMovies(context),
              ),
              //build What to watch movies
              SizedBox(height: 300, child: buildWhatToWatch(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabBarAndTabViewMovies(BuildContext context) {
    return Column(
      children: [
        //build TabBar
        SizedBox(
          height: 30,
          child: TabBar(
              controller: _dashBoardBloc.tabController,
              indicator: const BoxDecoration(shape: BoxShape.circle),
              labelPadding: const EdgeInsets.only(right: 18),
              labelColor: const Color(0xffef1951),
              // chuyển màu xám khi không chọn
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Text(
                  "Featured",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  "New release",
                  style: TextStyle(fontSize: 17),
                ),
                Text(
                  "Series",
                  style: TextStyle(fontSize: 17),
                ),
              ]),
        ),
        //build TabView
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 5),
            width: double.maxFinite,
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _dashBoardBloc.tabController,
                children: [
                  //build Featured TabBar
                  _buildListMoviesWithDotIndicator(
                      context, _dashBoardBloc.listMovieFeatured),
                  // build NewRealese TabBar(),
                  _buildListMoviesWithDotIndicator(
                      context, _dashBoardBloc.listMovieNewRealese),
                  // build Series TabBar(),
                  _buildListMoviesWithDotIndicator(
                      context, _dashBoardBloc.listMovieSeries),
                ]),
          ),
        ),
      ],
    );
  }


  _buildListMoviesWithDotIndicator(BuildContext context, Set<Movie> listMovie) {
    return Stack(
      children: [
        PageView.builder(
          controller: _dashBoardBloc.dashBoardController,
          itemCount: listMovie.length,
          itemBuilder: (context, index) {
            final movie = listMovie.elementAt(index);
            final urlPhoto = movie.urlPhoto;
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MovieProfilePage(movie: movie),
              )),
              child: MyImageInClipRRect(
                urlPhoto: urlPhoto,
                width: MediaQuery.of(context).size.width,
              ),
            );
          },
        ),

        //Dot indicator
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10),
          child: SmoothPageIndicator(
            controller: _dashBoardBloc.dashBoardController,
            count: listMovie.length,
            effect: const WormEffect(
              dotColor: Colors.grey,
              activeDotColor: Colors.white,
              dotHeight: 8,
              dotWidth: 8,
              type: WormType.thin,
            ),
          ),
        )
      ],
    );
  }

  Widget buildWhatToWatch(BuildContext context) {
    return Column(
      children: [
        //Text "What to watch" 
        Container(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            alignment: Alignment.centerLeft,
            child: const Text(
              "What to watch",
              style: TextStyle(color: Color(0xffee0342), fontSize: 16),
            )),
        //List View
        SizedBox(
          height: 200,
          child: _buildListViewMoviesWhatToWatch(listMovieWhatToWatch),
        ),
      ],
    );
  }

  Widget _buildListViewMoviesWhatToWatch(Set<Movie> listMovieWhatToWatch) {
    final width = MediaQuery.of(context).size.width;
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: listMovieWhatToWatch.length,
      itemBuilder: (context, index) {
        final movie = listMovieWhatToWatch.elementAt(index);
        final urlPhoto = movie.urlPhoto;
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MovieProfilePage(movie: movie),
          )),
          child: MyImageInClipRRect(
              width: 3 * (width - 20) / 10, urlPhoto: urlPhoto),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: ((width - 20) / 20),
        );
      },
    );
  }
}
