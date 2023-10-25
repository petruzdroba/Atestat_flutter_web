import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';

class IconHoverAction extends StatefulWidget {
  final IconData icon;
  final Function function;

  const IconHoverAction(this.icon, this.function, {super.key});

  @override
  State<IconHoverAction> createState() => _IconHoverActionState();
}

class _IconHoverActionState extends State<IconHoverAction> {
  bool didHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.function();
        });
      },
      child: MouseRegion(
        onEnter: (f) {
          setState(() {
            didHover = true;
          });
        },
        onExit: (f) {
          setState(() {
            didHover = false;
          });
        },
        child: SizedBox(
          width: 100,
          height: 10,
          child: Icon(
            widget.icon,
            size: 50,
            color: !didHover ? colorOffWhite : colorLightPurple,
          ),
        ),
      ),
    );
  }
}
