import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/config.dart';
import 'package:flutter_club_blaga/Widgets/Style/theme/dark_theme.dart';

import 'Service/Routes.dart';
import 'Widgets/Style/theme/light_theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState(){
    super.initState();
    currentTheme.addListener(() {
      print('aaa');
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: routerDelegate,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: currentTheme.currentTheme(),
      routeInformationParser: BeamerParser(),
    );
  }
}



