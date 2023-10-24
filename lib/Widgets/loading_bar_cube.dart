import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Style/colors_style.dart';

class LoadingBarCube extends StatelessWidget {
  const LoadingBarCube({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: SpinKitFadingCube(
        color: colorLightPurple,
        duration: const Duration(milliseconds: 1000),
        size:75.0, // Change to your desired size
      ),
    );
  }
}
