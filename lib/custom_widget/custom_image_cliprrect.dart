import 'package:flutter/material.dart';

class MyImageInClipRRect extends StatelessWidget {
  const MyImageInClipRRect({
    super.key,
    this.width,
    this.height,
    required this.urlPhoto,
  });

  final double? width;
  final double? height;
  final String urlPhoto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(urlPhoto, fit: BoxFit.fill,)),
    );
  }
}