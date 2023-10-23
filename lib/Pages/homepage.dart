import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/button_hover.dart';
import 'package:flutter_club_blaga/Widgets/navigation_bar.dart';

import '../Class/MenuOption.dart';

class HomePage extends StatefulWidget {
  List<MenuOption> _menuOptions = options;

  set menuOptions(List<MenuOption> value) {
    _menuOptions = value;
  }

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black87,
        child: Row(
          children: [
            SideNavigationBar(widget._menuOptions, '/home'),
            Expanded(
              flex: 9,
              child: Center(
                child: WidgetButtonHover(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
