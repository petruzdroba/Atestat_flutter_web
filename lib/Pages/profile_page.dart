import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/navigation_bar.dart';
import 'package:flutter_club_blaga/Widgets/profile_display.dart';

import '../Class/MenuOption.dart';
import '../Class/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User user = User(
      'petruzdroba',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0Gru9G3h6HXfS6f2F9S0gTm49NAyDwU2jiQ&usqp=CAU',
      'Petru Zdroba');
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
            SideNavigationBar(_menuOptions, '/profile'),
            Expanded(
              flex: 9,
              child: Padding(
                  padding: const EdgeInsets.only(
                      top: 55, left: 55, right: 55, bottom: 70),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDisplay(user: user),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
