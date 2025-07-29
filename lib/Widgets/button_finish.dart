import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Style/assets/fonts/weights.dart';

class ButtonFinish extends StatefulWidget {
  final String text;
  final Function function;

  const ButtonFinish({super.key, required this.text, required this.function});

  @override
  State<ButtonFinish> createState() => _ButtonFinishState();
}

class _ButtonFinishState extends State<ButtonFinish> {
  bool didHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.function();
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: !didHover ? 55 : 60,
          decoration: BoxDecoration(
              color: !didHover
                  ? Theme.of(context).colorScheme.background
                  : Theme.of(context).colorScheme.outline,
              border: Border.all(
                  width: 1.5,
                  color: !didHover
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(360)),
          child: Center(
              child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.mukta(
                fontSize: !didHover ? 20 : 22,
                fontWeight: !didHover ? medium : semiBold,
                color: !didHover
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onPrimary),
            child: Text(
              widget.text,
            ),
          )),
        ),
      ),
    );
  }
}
