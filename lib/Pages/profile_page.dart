import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/current_username.dart';
import 'package:flutter_club_blaga/Widgets/Style/assets/fonts/weights.dart';
import 'package:flutter_club_blaga/Widgets/navigation_bar.dart';
import 'package:flutter_club_blaga/Widgets/profile_display.dart';
import 'package:flutter_club_blaga/Widgets/user_product_display.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Class/MenuOption.dart';
import '../Class/user.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<MenuOption> _menuOptions = options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                      top: 55, left: 55, right: 55, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDisplay(user: widget.user),
                      const SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Products for sale:',
                        style: GoogleFonts.mukta(
                            fontSize: 30,
                            fontWeight: medium,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            widget.user.created_products_id.isNotEmpty
                                ? UserProductDisplay(
                                    productIds: widget.user.created_products_id,
                                  )
                                : Center(
                                    child: Text(
                                      currentUsername.currentusername == widget.user.username ? "You don't have anything up for sale !" : 'No products for sale !',
                                      style: GoogleFonts.mukta(
                                        fontSize: 22,
                                        color: Theme.of(context).colorScheme.primary,
                                        fontWeight: regular,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
