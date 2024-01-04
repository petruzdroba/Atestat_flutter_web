import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Class/MenuOption.dart';
import 'package:flutter_club_blaga/Class/current_username.dart';
import 'package:flutter_club_blaga/Widgets/icon_hover_action.dart';
import 'package:flutter_club_blaga/Widgets/small_option_box_menu.dart';

class OptionBuilder extends StatefulWidget {
  const OptionBuilder({super.key});

  @override
  State<OptionBuilder> createState() => _OptionBuilderState();
}

class _OptionBuilderState extends State<OptionBuilder> {
  bool showOptions = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconHoverAction(
          Icons.menu_rounded,
          () {
            setState(() {
              showOptions = !showOptions;
            });
          },
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: !showOptions ? 0 : 200,
          width: !showOptions ? 0 : 150,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SmallOptionBoxMenu(
                    name: 'Log Out',
                    icon: Icons.logout,
                    color: Theme.of(context).colorScheme.primary,
                    function: () {
                      currentUsername.currentusername = '-1';
                      menuReset();
                      Beamer.of(context).beamToNamed('/home',
                          replaceRouteInformation: true);
                    },
                ),
                const SizedBox(
                  height: 5,
                ),
                SmallOptionBoxMenu(
                  name: 'Edit',
                  icon: Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                  function: () {
                    Beamer.of(context).beamToNamed('/edit_user');
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                SmallOptionBoxMenu(
                    name: 'Delete',
                    icon: Icons.delete_forever,
                    color: Colors.red,
                    function: () {
                      Beamer.of(context).beamToNamed('/home',
                          replaceRouteInformation: true);
                      Beamer.of(context).beamToNamed('/delete_user');
                    },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
