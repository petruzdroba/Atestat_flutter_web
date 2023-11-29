import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_club_blaga/Class/PopularProduct.dart';
import 'package:flutter_club_blaga/Widgets/gif_display.dart';
import 'package:flutter_club_blaga/Widgets/navigation_bar.dart';
import 'package:flutter_club_blaga/Widgets/text_hover_color_size.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Class/MenuOption.dart';
import '../Widgets/Style/assets/fonts/weights.dart';

class HomePage extends StatefulWidget {
  final PopularProduct _popularProduct;

  const HomePage(this._popularProduct, {super.key});

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
        color: Theme.of(context).colorScheme.background,
        child: Row(
          children: [
            SideNavigationBar(_menuOptions, '/home'),
            Expanded(
              flex: 9,
              child: Stack(
                children: [
                  GifDisplay(widget._popularProduct.gif),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 35, left: 35, right: 35, bottom: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                'Home',
                                style: GoogleFonts.mukta(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 75,
                                    fontWeight: bold,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 15,
                                        bottom: 15),
                                    child: TextHoverColorSize(
                                        'Most popular item',
                                        50,
                                        Theme.of(context).colorScheme.primary,
                                        Theme.of(context).colorScheme.outline, () {
                                      Beamer.of(context).popToNamed(
                                          '/shop/product${widget._popularProduct.id}');
                                    }),
                                  )),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget._popularProduct.name,
                                    style: GoogleFonts.mukta(
                                      fontSize: 60,
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: medium,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: TextHoverColorSize(
                                      '€${widget._popularProduct.price}',
                                      45,
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.background, () {
                                    Clipboard.setData(ClipboardData(
                                        text:
                                            '€${widget._popularProduct.price}'));
                                  }),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    'sold by   ',
                                    style: GoogleFonts.mukta(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontSize: 23,
                                      fontWeight: light,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: TextHoverColorSize(
                                      widget._popularProduct.author,
                                      35,
                                      Theme.of(context).colorScheme.primary,
                                      Theme.of(context).colorScheme.background,
                                      () {} //Add later profile opening to seller profile
                                      ),
                                ),
                              ],
                            ),
                          ],
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
