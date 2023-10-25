import 'package:flutter/material.dart';

class MenuOption {
  String option = '';
  IconData icon =Icons.add;
  String route = '/';

  MenuOption(this.option, this.icon, this.route);
}

List<MenuOption> options = [
  MenuOption('Menu', Icons.menu, '/home'),
  MenuOption('Profile', Icons.person, '/profile'),
  MenuOption('Shop', Icons.shopping_basket, '/shop'),
  MenuOption('Example1', Icons.watch, '/example'),
  MenuOption('Example2', Icons.ring_volume, '/example')
];