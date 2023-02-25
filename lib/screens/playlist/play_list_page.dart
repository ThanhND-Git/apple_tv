import 'package:flutter/material.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({super.key});

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 66, 66, 66),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
            child: Text(
                "Thư viện của bạn trống.Các chương trình TV và phim mà bạn thêm vào thư viện sẽ xuất hiện tại đây.")),
      ),
    );
  }
}
