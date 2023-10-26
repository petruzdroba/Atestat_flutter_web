import 'package:flutter/material.dart';

class GifDisplay extends StatelessWidget {
  final String assetLocation;
  const GifDisplay(this.assetLocation, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(assetLocation),
            fit: BoxFit.cover, // Scale and cover the whole screen
          ),
        ),
      ),
    );
  }
}
