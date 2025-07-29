import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        background: colorOffWhite,
        primary: colorOffBlack,
        onPrimary: colorPureWhite,
        outline: colorDarkPurple,
        onSecondary: colorPureBlack,
    ));
