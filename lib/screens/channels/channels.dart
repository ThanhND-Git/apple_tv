import 'package:flutter/material.dart';
import '../../custom_widget/custom_image_cliprrect.dart';
import '../../models/channel.dart';
import 'channels_bloc.dart';

class ChannelsPage extends StatefulWidget {
  const ChannelsPage({super.key});

  @override
  State<ChannelsPage> createState() => _ChannelsPageState();
}

class _ChannelsPageState extends State<ChannelsPage>
    with TickerProviderStateMixin {
  late final ChannelsPageBloc _channelsPageBloc;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _channelsPageBloc = ChannelsPageBloc();
    _channelsPageBloc.tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _channelsPageBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.grey.shade800,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //build TabBar
            SizedBox(
              height: 30,
              child: TabBar(
                  controller: _channelsPageBloc.tabController,
                  indicator: const BoxDecoration(),
                  labelPadding: const EdgeInsets.only(right: 18),
                  labelColor: const Color(0xffef1951),
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Text(
                      "Channels",
                      style: TextStyle(fontSize: 17),
                    ),
                    Text(
                      "Trending",
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
                    controller: _channelsPageBloc.tabController,
                    children: [
                      //build Featured
                      _buildFeaturedTabView(context),
                      // build NewRealese
                      const Center(
                          child: Text("Đang cập nhật. Vui lòng quay lại sau")),
                      // build Series
                      const Center(
                          child: Text("Đang cập nhật. Vui lòng quay lại sau")),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedTabView(BuildContext context) {
    return FutureBuilder(
      future: _channelsPageBloc.compareAndUpdateListChannel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Có 1 lỗi đã xảy ra!'));
          }
          final listChannels = snapshot.data!;
          return _buildGridViewChannel(listChannels);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildGridViewChannel(Set<Channel> listChannels) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1 / 2,
        mainAxisExtent: 350,
      ),
      itemCount: listChannels.length,
      itemBuilder: (context, index) {
        final channel = listChannels.elementAt(index);
        final imageUrl = channel.imageUrl;
        return SizedBox(
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyImageInClipRRect(width: 200, height: 250, urlPhoto: imageUrl),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 34,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          channel.name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                        StreamBuilder<bool>(
                            stream: _channelsPageBloc.isLikedStream,
                            builder: (context, snapshot) {
                              final isLiked = channel.isLiked;
                              return IconButton(
                                  onPressed: () async {
                                    await _channelsPageBloc.setIsLiked(channel);
                                    await _channelsPageBloc
                                        .handleChannels(channel);
                                  },
                                  icon: Icon(
                                    Icons.thumb_up,
                                    color: isLiked == false
                                        ? Colors.grey
                                        : IconTheme.of(context).color,
                                    size: 16,
                                  ));
                            })
                      ],
                    ),
                  ),
                  Text(
                    channel.describe,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  Text(
                    '${channel.numberOfChannels} channels',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
