import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Style/assets/fonts/weights.dart';

class TextHoverColor extends StatefulWidget {
  final String text;
  final double size;
  final Color fromColor;
  final Color toColor;
  final Function function;
  const TextHoverColor({super.key, required this.text, required this.size, required this.fromColor, required this.toColor, required this.function});

  @override
  State<TextHoverColor> createState() => _TextHoverColorState();
}

class _TextHoverColorState extends State<TextHoverColor> {
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
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.mukta(
                fontSize: widget.size,
                fontWeight: !didHover ? medium : semiBold,
                color: !didHover
                    ? widget.fromColor
                    : widget.toColor),
            child: Text(widget.text)
          )
      ),
    );
  }
}
