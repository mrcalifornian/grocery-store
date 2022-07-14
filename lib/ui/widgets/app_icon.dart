import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final String assetIcon;
  const AppIcon({Key? key, required this.assetIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/icons/$assetIcon.png",
      height: 20,
      width: 20,
    );
  }
}
