import 'dart:async';

import 'package:flutter/material.dart';
import 'package:apple_tv/base/bloc.dart';
import 'package:apple_tv/models/channel.dart';

import '../../shared_preferences/shared_preferences.dart';

class ChannelsPageBloc extends Bloc {
  late TabController _tabController;
  // ignore: unnecessary_getters_setters
  TabController get tabController => _tabController;
  set tabController(TabController value) {
    _tabController = value;
  }

  //create List Channels
  final Set<Channel> _listChannelsFeatured = Bloc().listChannels;
  Set<Channel> get listChannelsFeatured => _listChannelsFeatured;

  final _isLikedStreamController = StreamController<bool>.broadcast();
  Stream<bool> get isLikedStream => _isLikedStreamController.stream;
  StreamSink get _isLikedSink => _isLikedStreamController.sink;

  //init Favorite Channel List and compare received Channel with Channels in favorite list to set Icon Like in Channel Profile Page
  Future<Set<Channel>> compareAndUpdateListChannel() async {
    Set<Channel> listChannels =
        await MySharedPreferences.getListFavoriteChannels();
    for (var element in listChannelsFeatured) {
      if (listChannels.contains(element)) {
        element.isLiked = true;
      }
    }
    return listChannelsFeatured;
  }

  //set isLiked for channel
  Future<void> setIsLiked(Channel channel) async {
    channel.isLiked = !channel.isLiked;
    _isLikedSink.add(channel.isLiked);
  }

  //handle Channels if liked or not
  Future<void> handleChannels(Channel channel) async {
    if (channel.isLiked) {
      await addChannelsToListFavorite(channel);
    } else {
      await removeChannelsToListFavorite(channel);
    }
  }

  Future<void> addChannelsToListFavorite(Channel channel) async {
    //get listChannels from MySharedPreferences
    Set<Channel> listChannels =
        await MySharedPreferences.getListFavoriteChannels();
    //add Channels to list
    listChannels.add(channel);
    MySharedPreferences.saveListFavoriteChannel(listChannels);
  }

  Future<void> removeChannelsToListFavorite(Channel channel) async {
    //get listChannels from MySharedPreferences
    Set<Channel> listChannels =
        await MySharedPreferences.getListFavoriteChannels();
    //remove Channels to list
    listChannels.remove(channel);
    MySharedPreferences.saveListFavoriteChannel(listChannels);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _isLikedStreamController.close();
    super.dispose();
  }
}
