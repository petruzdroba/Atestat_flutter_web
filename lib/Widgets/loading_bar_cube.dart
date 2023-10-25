import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Style/colors_style.dart';

class LoadingBarCube extends StatelessWidget {
  final double size;
  final int duration;
  const LoadingBarCube(this.size, this.duration,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: SpinKitFadingCube(
        color: colorLightPurple,
        duration: Duration(milliseconds: duration),
        size:size, // Change to your desired size
      ),
    );
  }
}
