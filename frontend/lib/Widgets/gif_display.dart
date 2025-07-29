import 'package:flutter/material.dart';

import 'loading_bar_cube.dart';

class GifDisplay extends StatefulWidget {
  final String assetLocation;
  const GifDisplay(this.assetLocation, {Key? key}) : super(key: key);

  @override
  GifDisplayState createState() => GifDisplayState();
}

class GifDisplayState extends State<GifDisplay> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadGifImage();
  }

  _loadGifImage() async {
    await precacheImage(NetworkImage(widget.assetLocation), context);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? const LoadingBarCube(75.0, 1000) // Show a loading indicator
          : Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.assetLocation),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
