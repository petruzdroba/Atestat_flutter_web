import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';
import 'package:flutter_club_blaga/Widgets/gif_display.dart';
import 'package:flutter_club_blaga/Widgets/navigation_bar.dart';
import 'package:flutter_club_blaga/Widgets/text_hover_color_size.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Class/MenuOption.dart';
import '../Widgets/Style/assets/fonts/weights.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            'Home',
                            style: GoogleFonts.mukta(
                                color: colorOffWhite,
                                fontSize: 75,
                                fontWeight: bold,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Flexible(
                          child: Container(
                              color: colorPureBlack,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 15,
                                    bottom: 15),
                                child: TextHoverColorSize(
                                    'Most popular item',
                                    50,
                                    colorOffWhite,
                                    colorLightPurple,
                                    (){
                                      Beamer.of(context).popToNamed(
                                          '/shop/product$mostPopularItemId');
                                    }),
                              )),
                        )
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
