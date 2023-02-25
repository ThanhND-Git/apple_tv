import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../channels/channels.dart';
import '../favorite/favorite.dart';
import '../dashboard/dash_board.dart';
import '../playlist/play_list_page.dart';
import 'home_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _homeBloc = HomeBloc();
  @override
  void dispose() {
    _homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(
          backgroundColor: Color.fromARGB(255, 66, 66, 66),
            child: Center(
          child: Text("Menu"),
        )),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "AppleTV",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          backgroundColor: Colors.grey.shade800,
          actions: [
            //search icon
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                )),
          ],
          leading: Builder(builder: (context) {
            return IconButton(
              color: Colors.grey,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
              ),
            );
          }),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 1),
          color: Colors.grey,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _homeBloc.pageController,
            children: const [
              DashBoardPage(),
              ChannelsPage(),
              FavoritePage(),
              PlayListPage(),
            ],
          ),
        ),
        // Bottom Bar
        bottomNavigationBar: StreamBuilder<int>(
            initialData: _homeBloc.initCurrentPage,
            stream: _homeBloc.currentPageStream,
            builder: (context, snapshot) {
              final currentPage = snapshot.data ?? _homeBloc.initCurrentPage;
              return BottomNavigationBar(
                backgroundColor: Colors.grey.shade800,
                type: BottomNavigationBarType.fixed,
                onTap: (value) => _homeBloc.changePageIndex(value),
                currentIndex: currentPage,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                //đổi màu ở bottombar
                selectedItemColor: IconTheme.of(context).color,
                unselectedItemColor: Colors.grey.shade400,

                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.dashboard,
                      ),
                      label: 'Dash Board'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        CupertinoIcons.tv_fill,
                      ),
                      label: 'Channels'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.thumb_up), label: 'Favorite'),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.playlist_add_rounded,
                        size: 32,
                      ),
                      label: 'Play List'),
                ],
              );
            }),
      ),
    );
  }
}
