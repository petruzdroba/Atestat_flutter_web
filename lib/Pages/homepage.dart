import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';
import 'package:flutter_club_blaga/Widgets/gif_display.dart';
import 'package:flutter_club_blaga/Widgets/navigation_bar.dart';
import 'package:flutter_club_blaga/Widgets/text_hover_color_size.dart';

import '../Class/MenuOption.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MenuOption> _menuOptions = options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black87,
        child: Row(
          children: [
            SideNavigationBar(_menuOptions, '/home'),
            Expanded(
              flex: 9,
              child: Stack(
                children: [
                  const GifDisplay('lib/Widgets/Style/assets/gif.gif'),
                  Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Home',
                          style: TextStyle(
                            color: colorOffWhite,
                            fontSize: 75,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline
                          ),
                        ),
                        InkWell(onTap: (){
                          Beamer.of(context)
                              .popToNamed('/shop/product$mostPopularItemId');
                        },
                            child: TextHoverColorSize('Most popular item', 60, colorOffBlack, colorPureBlack))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
