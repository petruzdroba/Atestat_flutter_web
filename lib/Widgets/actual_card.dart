import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_club_blaga/Widgets/Style/colors_style.dart';
import 'package:google_fonts/google_fonts.dart';

class ActualCard extends StatefulWidget {
  final String text;
  final int size;

  const ActualCard(this.text, this.size, {Key? key}) : super(key: key);

  @override
  State<ActualCard> createState() => _ActualCardState();
}

class _ActualCardState extends State<ActualCard> {
  bool didHover = false;

  Color getRandomColor() {
    final random = Random();
    final List<Color> allowedColors = [
      const Color(0xFF474747),
      const Color(0xFF353535),
      const Color(0xFF232323),
    ];
    return allowedColors[random.nextInt(allowedColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: !didHover
              ? (widget.size * 100).toDouble()
              : (widget.size * 100).toDouble() + 55,
          height: !didHover ? 150 : 175,
        ),
        MouseRegion(
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
            decoration: BoxDecoration(
              color: !didHover ? getRandomColor() : colorOffWhite, // Change to white
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: colorGray, width: 0.5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey, // Shadow color
                  offset: Offset(0, 4), // Offset of the shadow
                  blurRadius: 10, // Spread of the shadow
                ),
              ],// Use grey
            ),
            width: 550,
            height: 350,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    transform: !didHover ? Matrix4.rotationZ(3.14159265359 / 2) : Matrix4.rotationZ(0),
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 325),
                      style: GoogleFonts.mukta(
                        fontSize: 30,
                        color: didHover ? colorOffBlack : colorOffWhite,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                      ),
                      child: Text(widget.text),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
