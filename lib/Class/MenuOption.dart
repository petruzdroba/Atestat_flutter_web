import 'package:flutter/material.dart';

class MenuOption {
  String option = '';
  IconData icon =Icons.add;
  String route = '/';

  MenuOption(this.option, this.icon, this.route);
}

int mostPopularItemId = 20051511;

List<MenuOption> options = [
  MenuOption('Home', Icons.home, '/home'),
  MenuOption('Profile', Icons.person, '/profile'),
  MenuOption('Shop', Icons.shopping_basket, '/shop'),
  MenuOption('Sell', Icons.sell_rounded, '/sell'),
  MenuOption('Example2', Icons.ring_volume, '/example')
];