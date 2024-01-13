import 'package:flutter/material.dart';

class ConfirmActionIcon extends StatefulWidget {
  final IconData icon;
  final IconData secondIcon;
  final Color color;
  final Function function;

  const ConfirmActionIcon(
      {super.key,
      required this.icon,
      required this.function,
      required this.secondIcon,
      required this.color});

  @override
  State<ConfirmActionIcon> createState() => _ConfirmActionIconState();
}

class _ConfirmActionIconState extends State<ConfirmActionIcon> {
  bool nrPressed = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!nrPressed) {
          setState(() {
            nrPressed = true;
          });
        } else {
          widget.function();
        }
      },
      child: Icon(
        !nrPressed ? widget.icon : widget.secondIcon,
        color: widget.color,
        size: 25,
      ),
    );
  }
}
