import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/current_username.dart';

class MenuOption {
  String option = '';
  IconData icon =Icons.add;
  String route = '/';

  MenuOption(this.option, this.icon, this.route);
}

List<MenuOption> options = [
  MenuOption('Home', Icons.home, '/home'),
  MenuOption('Profile', Icons.person, '/profile/${currentUsername.currentusername}'),
  MenuOption('Shop', Icons.shopping_basket, '/shop'),
  MenuOption('Sell', Icons.sell_rounded, '/sell'),
  MenuOption('Example2', Icons.ring_volume, '/example')
];