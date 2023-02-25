import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final double size;
  final String imageAsset;

  const CustomIcon({super.key, required this.size, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(imageAsset),
    );
  }
}
