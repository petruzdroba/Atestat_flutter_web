import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';
import 'package:flutter_club_blaga/Widgets/navigation_bar.dart';

import '../Class/MenuOption.dart';

class ErrorPage extends StatefulWidget {

  final String errorMessage;

  const ErrorPage(this.errorMessage, {super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  final List<MenuOption> _menuOptions = options;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black87,
        child: Row(
          children: [
            SideNavigationBar(_menuOptions, '/error'),
            Expanded(
              flex: 9,
              child: Center(
                child: Text(
                  widget.errorMessage,
                  style: TextStyle(
                    color: colorOffWhite,
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}