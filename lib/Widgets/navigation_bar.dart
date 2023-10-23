import 'package:flutter/material.dart';

import '../Class/MenuOption.dart';
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
        color: Colors.black54,
        child: Column(
          children: widget._options.map((option) {
            return BoxListHover(option.option, option.icon, option.route, currentRoute);
          }).toList(),
        ),
      ),
    );
  }
}
