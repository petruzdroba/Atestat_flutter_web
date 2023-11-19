import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/config.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Class/MenuOption.dart';
import 'Style/assets/fonts/weights.dart';
import 'box_list_hover.dart';

class SideNavigationBar extends StatefulWidget {
  final List<MenuOption> _options;
  final String _currentRoute;

  const SideNavigationBar(this._options, this._currentRoute, {super.key});

  @override
  State<SideNavigationBar> createState() => _SideNavigationBarState();
}

class _SideNavigationBarState extends State<SideNavigationBar> {
  String get currentRoute => widget._currentRoute;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            const SizedBox(
              height: 7,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('LILIAC',
                    style: GoogleFonts.oxanium(
                        fontSize: 30,
                        fontWeight: bold,
                        color: Theme.of(context).colorScheme.outline)),
                InkWell(
                  onTap: () {
                    currentTheme.switchThemes();
                  },
                  child: Container(
                    width: 28,
                    height: 28,
                    color: Theme.of(context).colorScheme.background,
                    child: Icon(currentTheme.currentTheme() != ThemeMode.light
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color:Theme.of(context).colorScheme.outline),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            Column(
              children: widget._options.map((option) {
                return BoxListHover(
                    option.option, option.icon, option.route, currentRoute);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
