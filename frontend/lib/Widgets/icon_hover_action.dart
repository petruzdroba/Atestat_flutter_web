import 'package:flutter/material.dart';

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
          width: 50,
          height: 50,
          child: Icon(
            widget.icon,
            size: 50,
            color: !didHover ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    );
  }
}
