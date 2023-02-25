import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:apple_tv/base/bloc.dart';

class HomeBloc extends Bloc {
  PageController pageController = PageController();
  //mặc định là trang có index là 0
  int _currentPage = 0;
  final _currentPageStreamController = StreamController<int>.broadcast();
  Stream<int> get currentPageStream => _currentPageStreamController.stream;
  StreamSink get _currentPageSink => _currentPageStreamController.sink;

  //get init currentPage : trang đầu tiên
  int get initCurrentPage => 0;

  void changePageIndex(int index) {
    //on tap => set curentpage = index và nhảy tới trang với index đã chọn
    _currentPage = index;
    _currentPageSink.add(_currentPage);
    pageController.jumpToPage(index);
  }

  @override
  void dispose() {
    _currentPageStreamController.close();
    super.dispose();
  }
}
